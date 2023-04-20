from django.urls import path
from . import views

urlpatterns = [
    #messages
    path('message_list/', views.message_list, name='display message_list'),
    #reports
    path('report_list/', views.report_list, name='display report_list'),
    # user settings
    path('user_settings/', views.user_settings, name='display user_settings'),
]
