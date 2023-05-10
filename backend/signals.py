from django.conf import settings
from django.dispatch import receiver
from django.db.models.signals import post_save
from .models import User, UserSettings

@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_user(sender, **kwargs):
    if kwargs['created']:
        user = kwargs['instance']

        user = User.objects.create(user = user)
        UserSettings.objects.create(user = user, theme = 'dark', notifications = True)


