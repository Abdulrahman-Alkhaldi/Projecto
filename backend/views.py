from django.shortcuts import render
from .models import *
from .serializers import *
from django_filters.rest_framework import DjangoFilterBackend
from .filters import MessageFilter
from rest_framework import pagination, mixins, status, filters, viewsets
from rest_framework.response import Response
from rest_framework.decorators import action
from .permissions import IsOwner, UnsendMessagePermission
from account.models import User as AccountUser

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
    # queryset = AccountUser.objects.select_related('user__user_settings').all()
    serializer_class = UserSerializer 
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['first_name', 'last_name', 'email']
    search_fields = ['first_name', 'last_name', 'email']
    ordering_fields = ['first_name', 'last_name']

    def get_queryset(self):
        if self.request.user.is_authenticated:
            if self.request.user.groups.filter(name='moderator').exists():
                return AccountUser.objects.select_related('user__user_settings').all()
            return AccountUser.objects.select_related('user__user_settings').filter(id=self.request.user.id)
        return AccountUser.objects.none()
    
    @action(detail=False, methods=['get', 'put'])
    def me(self, request):
        # check if user is authenticated
        if not request.user.is_authenticated:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        if request.method == 'PUT':
            serializer = UserSerializer(request.user, data=request.data, partial=True)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data)
        if request.method == 'GET':
            serializer = UserSerializer(request.user)
            return Response(serializer.data)
        return Response(status=status.HTTP_405_METHOD_NOT_ALLOWED)
# UserSettingsViewSet
class UserSettingsViewSet(mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.ListModelMixin, viewsets.GenericViewSet):
    # Nested viewset
    serializer_class = UserSettingsSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['theme', 'notifications']
    search_fields = ['theme']
    ordering_fields = ['theme', 'notifications']
    permission_classes = [IsOwner] 
    def get_queryset(self):
        user_id = self.kwargs.get('user_pk', None)
        if user_id:
            return UserSettings.objects.select_related('user').filter(user_id=user_id)
        return UserSettings.objects.none()

# ReportedContentViewSet
class ReportedContentViewSet(viewsets.ModelViewSet):
    # queryset = ReportedContent.objects.select_related('reported_by', 'message__user').all()

    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['status']
    search_fields = ['reason']
    ordering_fields = ['reason', 'status', 'created_at']
    permission_classes = [IsOwner]    

    def get_serializer_class(self):
        if self.action == 'create':
            return ReportedContentCreateSerializer
        return ReportedContentSerializer

    def get_queryset(self):
        if self.request.user.is_authenticated:
            if self.request.user.groups.filter(name='moderator').exists():
                return ReportedContent.objects.select_related('reported_by', 'message__user').all()
            return ReportedContent.objects.select_related('reported_by', 'message__user').filter(reported_by_id=self.request.user.id)
        return ReportedContent.objects.none()
    
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
    # queryset = Message.objects.select_related('user').prefetch_related('attachment_set').all()
    queryset = Message.objects.select_related('user__user_settings',).prefetch_related('attachment_set', 'reportedcontent_set').all()
    allowed_methods = ['GET', 'POST', 'PUT', 'DELETE']
    # serializer_class = MessageSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter]
    filterset_class = MessageFilter
    ordering_fields = ['created_at']
    permission_classes = [UnsendMessagePermission]

    # custom pagination class
    class CustomPagination(pagination.PageNumberPagination):
        page_size = 3
    pagination_class = CustomPagination

    def get_serializer_class(self):
        if self.action == 'create':
            return MessageCreateSerializer
        return MessageSerializer
