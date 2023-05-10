from django.urls import path, include
from .views import *
# import default router
from rest_framework.routers import DefaultRouter
# import nested router
from rest_framework_nested.routers import NestedDefaultRouter



router = DefaultRouter()
router.register(r'users', UserViewSet, basename='myuser')
# router.register(r'usersettings', UserSettingsViewSet, basename='usersettings')
router.register(r'reportedcontent', ReportedContentViewSet, basename='reportedcontent')
router.register(r'messages', MessageViewSet, basename='messages')
router.register(r'attachments', AttachmentViewSet, basename='attachments')

# Nesting AttachmentViewSet under MessageViewSet
message_router = NestedDefaultRouter(router, r'messages', lookup='message')
message_router.register(r'attachments', NestedAttachmentViewSet, basename='message-attachments')
# nested user settings under user
user_router = NestedDefaultRouter(router, r'users', lookup='user')
user_router.register(r'usersettings', UserSettingsViewSet, basename='user-usersettings')

urlpatterns = [
    path('', include(router.urls)),
    path('', include(message_router.urls)),
    path('', include(user_router.urls)),
    #messages
    path('message_list/', message_list, name='display message_list'),
    #reports
    path('report_list/', report_list, name='display report_list'),
    # user settings
    path('user_settings/', user_settings, name='display user_settings')
]

