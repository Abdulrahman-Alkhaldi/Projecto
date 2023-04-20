from django.shortcuts import render
from .models import *
from rest_framework import viewsets
from .serializers import *
from rest_framework import filters
from django_filters.rest_framework import DjangoFilterBackend
from .filters import MessageFilter
from rest_framework import pagination
from rest_framework.response import Response
from rest_framework import status

# # Create your views here.
# def message_list(request):
#     messages = Message.objects.all()
#     return render(request, 'message_list.html', {'messages': messages})

# def report_list(request):
#     reports = ReportedContent.objects.all()
#     return render(request, 'report_list.html', {'reports': reports})

# def user_settings(request):
#     user_settings = UserSettings.objects.all()
#     return render(request, 'user_settings_list.html', {'user_settings': user_settings})
# UserViewSet
class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['first_name', 'last_name', 'email']
    search_fields = ['first_name', 'last_name', 'email']
    ordering_fields = ['first_name', 'last_name', 'created_at']

# UserSettingsViewSet
class UserSettingsViewSet(viewsets.ModelViewSet):
    queryset = UserSettings.objects.all()
    serializer_class = UserSettingsSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['theme', 'notifications']
    search_fields = ['theme']
    ordering_fields = ['theme', 'notifications']

# ReportedContentViewSet
class ReportedContentViewSet(viewsets.ModelViewSet):
    queryset = ReportedContent.objects.all()
    serializer_class = ReportedContentSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['reason', 'status']
    # search -> ["Said mean stuff to me :(", "Offensive content",  "Inappropriate language", "Spam",]
    search_fields = ['reason']
    ordering_fields = ['reason', 'status', 'created_at']

# AttachmentViewSet for specific message
class AttachmentViewSet(viewsets.ModelViewSet):
    queryset = Attachment.objects.all()
    serializer_class = CustomAttachmentSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['message']
    # this is useless but you asked for it :)
    search_fields = ['image']
    ordering_fields = ['message']
    
    def get_queryset(self):
        message_id = self.kwargs.get('message_pk', None)
        if message_id:
            return Attachment.objects.filter(message_id=message_id)

# extra viewset for all attachments
class AllAttachmentsViewSet(viewsets.ModelViewSet):
    queryset = Attachment.objects.all()
    serializer_class = CustomAttachmentSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['message']
    # this is useless but you asked for it :)
    search_fields = ['image']
    ordering_fields = ['message']

class MessageViewSet(viewsets.ModelViewSet):
    queryset = Message.objects.all()
    serializer_class = MessageSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter]
    filterset_class = MessageFilter
    ordering_fields = ['created_at']
    # this is useless but you asked for it :)
    search_fields = ['content']

    # custom pagination class
    class CustomPagination(pagination.PageNumberPagination):
        page_size = 3
    pagination_class = CustomPagination