from django.urls import path, include
from .views import *
# import default router
from rest_framework.routers import DefaultRouter
# import nested router
from rest_framework_nested.routers import NestedDefaultRouter





router = DefaultRouter()
router.register(r'users', UserViewSet, basename='user')
router.register(r'usersettings', UserSettingsViewSet, basename='usersettings')
router.register(r'reportedcontent', ReportedContentViewSet, basename='reportedcontent')
router.register(r'messages', MessageViewSet, basename='messages')
router.register(r'all_attachments', AllAttachmentsViewSet, basename='all_attachments')

# Nesting AttachmentViewSet under MessageViewSet
message_router = NestedDefaultRouter(router, r'messages', lookup='message')
message_router.register(r'attachments', AttachmentViewSet, basename='message-attachments')

urlpatterns = [
    path('', include(router.urls)),
    path('', include(message_router.urls)),
]

# urlpatterns = [
#     # #messages
#     # path('message_list/', views.message_list, name='display message_list'),
#     # #reports
#     # path('report_list/', views.report_list, name='display report_list'),
#     # # user settings
#     # path('user_settings/', views.user_settings, name='display user_settings'),
#     path('users/', views.UserViewSet.as_view({'get': 'list'}), name='user_list'),
# ]