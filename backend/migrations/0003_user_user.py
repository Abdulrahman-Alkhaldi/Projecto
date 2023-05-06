# Generated by Django 4.2.1 on 2023-05-06 20:34

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('backend', '0002_alter_usersettings_options_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='user',
            field=models.OneToOneField(default='1', on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
            preserve_default=False,
        ),
    ]