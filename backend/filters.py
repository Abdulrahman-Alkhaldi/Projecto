import django_filters
from .models import Message

#custom filter for messages
class MessageFilter(django_filters.FilterSet):
    user = django_filters.NumberFilter(field_name='user__id')
    content = django_filters.CharFilter(field_name='content', lookup_expr='icontains')

    class Meta:
        model = Message
        fields = ['user', 'content']
