from django.contrib import admin
from django.db.models import Count
from django.urls import reverse
from django.utils.html import format_html
from .models import *
# Register your models here.
# superuser
# username: admin
# password: admin

# register all of my models

class UserSettingsInline(admin.TabularInline):
    model = UserSettings
    can_delete = False
    verbose_name_plural = 'User Settings'

@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = ('id', 'first_name', 'last_name', 'email', 'message_count', 'notifications', 'created_at')
    list_per_page = 25
    search_fields = ('first_name', 'last_name', 'email')
    list_filter = ('created_at',)
    inlines = (UserSettingsInline,)

    def get_queryset(self, request):
        return super().get_queryset(request).annotate(message_count=Count('message'))

    @admin.display(description='Message Count')
    def message_count(self, user):
        url = reverse('admin:backend_message_changelist')
        return format_html('<a href="{}?user__id={}">{}</a>', url, user.id, user.message_count)
    
    @admin.display(description='Notifications', boolean=True)
    def notifications(self, user):
        return user.usersettings.notifications

@admin.register(UserSettings)
class UserSettingsAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'theme', 'notifications')
    list_per_page = 25
    list_filter = ('theme', 'notifications')
    search_fields = ('user__first_name', 'user__last_name')
    list_editable = ('theme',)
    actions = ['set_dark_mode']

    @admin.action(description='Set theme to dark')
    def set_dark_mode(self, request, queryset):
        queryset.update(theme='dark')

@admin.register(ReportedContent)
class ReportedContentAdmin(admin.ModelAdmin):
    list_display = ('id', 'reason', 'status', 'reported_by', 'message', 'created_at')
    list_per_page = 25
    list_filter = ('status', 'created_at')
    search_fields = ('reason',)
    list_editable = ('status',)


class HasReportFilter(admin.SimpleListFilter):
    title = 'Has Report'
    parameter_name = 'has_report'

    def lookups(self, request, model_admin):
        return (
            ('1', 'Yes'),
            ('0', 'No'),
        )

    def queryset(self, request, queryset):
        if self.value() == '1':
            reported_messages = ReportedContent.objects.values_list('message_id', flat=True)
            queryset = queryset.filter(id__in=reported_messages)
        elif self.value() == '0':
            reported_messages = ReportedContent.objects.values_list('message_id', flat=True)
            queryset = queryset.exclude(id__in=reported_messages)
        return queryset


class AttachmentInline(admin.TabularInline):
    model = Attachment
    can_delete = False
    verbose_name_plural = 'Attachments'
    extra = 1

@admin.register(Message)
class MessageAdmin(admin.ModelAdmin):
    list_display = ('id', 'content', 'user', 'created_at')
    list_per_page = 25
    list_filter = ('created_at', HasReportFilter)
    search_fields = ('content', 'user__first_name', 'user__last_name')
    inlines = (AttachmentInline,)

@admin.register(Attachment)
class AttachmentAdmin(admin.ModelAdmin):
    list_display = ('id', 'image', 'message')
    list_per_page = 25
    search_fields = ('file_name',)