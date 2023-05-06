from django.shortcuts import render
from .models import *
from .serializers import *
from django_filters.rest_framework import DjangoFilterBackend
from .filters import MessageFilter
from rest_framework import pagination, mixins, status, filters, viewsets
from rest_framework.response import Response
from rest_framework.decorators import action
from .permissions import IsOwner, UnsendMessagePermission


# # Create your views here.
def message_list(request):
    messages = Message.objects.all()
    return render(request, 'message_list.html', {'messages': messages})

def report_list(request):
    reports = ReportedContent.objects.all()
    return render(request, 'report_list.html', {'reports': reports})

def user_settings(request):
    user_settings = UserSettings.objects.all()
    return render(request, 'user_settings_list.html', {'user_settings': user_settings})

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.select_related('user_settings').all()
    serializer_class = UserSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['first_name', 'last_name', 'email']
    search_fields = ['first_name', 'last_name', 'email']
    ordering_fields = ['first_name', 'last_name', 'created_at']

    @action(detail=False, methods=['get', 'put'])
    def me(self, request):
        if request.method == 'PUT':
            serializer = UserSerializer(request.user, data=request.data, partial=True)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data)
        if request.method == 'GET':
            serializer = UserSerializer(request.user)
            return Response(serializer.data)


# UserSettingsViewSet
class UserSettingsViewSet(mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.ListModelMixin, viewsets.GenericViewSet):
    queryset = UserSettings.objects.select_related('user').all()
    serializer_class = UserSettingsSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['theme', 'notifications']
    search_fields = ['theme']
    ordering_fields = ['theme', 'notifications']
    permission_classes = [IsOwner]    

# ReportedContentViewSet
class ReportedContentViewSet(viewsets.ModelViewSet):
    queryset = ReportedContent.objects.select_related('reported_by', 'message__user').prefetch_related('message__attachment_set').all()
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['status']
    search_fields = ['reason']
    ordering_fields = ['reason', 'status', 'created_at']
    permission_classes = [IsOwner]    

    def get_serializer_class(self):
        if self.action == 'create':
            return ReportedContentCreateSerializer
        return ReportedContentSerializer

    
class NestedAttachmentViewSet(mixins.RetrieveModelMixin, mixins.ListModelMixin, mixins.UpdateModelMixin, viewsets.GenericViewSet):
    serializer_class = NestedAttachmentSerializer
    def get_queryset(self):
        message_id = self.kwargs.get('message_pk', None)
        if message_id:
            return Attachment.objects.filter(message_id=message_id)
    
        
class AttachmentViewSet(viewsets.ModelViewSet):
    queryset = Attachment.objects.select_related('message__user').all()
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['message']
    search_fields = ['image']
    ordering_fields = ['message']
    serializer_class = AttachmentSerializer
    permission_classes = [UnsendMessagePermission]    



class MessageViewSet(viewsets.ModelViewSet):
    queryset = Message.objects.select_related('user').prefetch_related('attachment_set').all()
    serializer_class = MessageSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter]
    filterset_class = MessageFilter
    ordering_fields = ['created_at']
    # this is useless but you asked for it :)
    search_fields = ['content']
    permission_classes = [UnsendMessagePermission]

    # custom pagination class
    class CustomPagination(pagination.PageNumberPagination):
        page_size = 3
    pagination_class = CustomPagination