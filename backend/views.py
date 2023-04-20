from django.shortcuts import render
from .models import *

# Create your views here.
def message_list(request):
    messages = Message.objects.all()
    return render(request, 'message_list.html', {'messages': messages})

def report_list(request):
    reports = ReportedContent.objects.all()
    return render(request, 'report_list.html', {'reports': reports})

def user_settings(request):
    user_settings = UserSettings.objects.all()
    return render(request, 'user_settings_list.html', {'user_settings': user_settings})