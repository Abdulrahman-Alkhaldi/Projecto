from django.db import models
from django.core.exceptions import ValidationError

# Create your models here.


class User(models.Model):
    # we'll use authentication from django later
    # username = models.CharField(max_length=50)
    # password = models.CharField(max_length=50)
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    email = models.EmailField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    
    def clean(self):
        # check if email is unique
        if User.objects.filter(email=self.email).exists():
            raise ValidationError("Email already exists")

    
    def __str__(self):
        return f"{self.first_name} {self.last_name}"

class UserSettings(models.Model):
    # add theme theme choices 
    THEME_CHOICES = [
        ('light', 'Light'),
        ('dark', 'Dark'),
    ]
    theme = models.CharField(max_length=5, choices=THEME_CHOICES, default='dark')
    notifications = models.BooleanField(default=True)
    # FK's
    user = models.OneToOneField(User, on_delete=models.CASCADE,related_name='user_settings')
    
    class Meta:
        verbose_name_plural = "UserSettings"

    def clean(self):
        # check if user is unique
        if UserSettings.objects.filter(user=self.user).exists():
            raise ValidationError("User already has settings")

    def __str__(self):
        return f"{self.user.first_name} {self.user.last_name}'s settings"

class ReportedContent(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('resolved', 'Resolved'),
        ('rejected', 'Rejected'),
    ]
    reason = models.CharField(max_length=255)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='pending')
    created_at = models.DateTimeField(auto_now_add=True)
    # FK's
    reported_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    message = models.ForeignKey('Message', on_delete=models.CASCADE)

    #user can't report same message twice
    def clean(self):
        if ReportedContent.objects.filter(message=self.message, reported_by=self.reported_by).exists():
            raise ValidationError("User already reported this message")
    
    def __str__(self):
        return f"{self.reported_by} reported a message for {self.reason}"
    
class Message(models.Model):
    # nullable so user can send an attachment without a message
    content = models.CharField(max_length=255, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    # FK's
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)

    # raise error if user tries to send a message without content or attachment
    def clean(self):
        if not self.content and not self.attachment_set.exists():
            raise ValidationError("Message must have content or attachment")

    def __str__(self):
        return f"sent by {self.user} at {self.created_at.strftime('%Y-%m-%d %H:%M:%S')}"
    
class Attachment(models.Model):
    image = models.ImageField(upload_to='attachments/')
    message = models.ForeignKey(Message, on_delete=models.CASCADE)

    def file_name(self):
        if self.image:
            return self.image.name.split('/')[-1]
        return ''

    def file_size(self):
        if self.image:
            return self.image.size
        return 0

    def content_type(self):
        if self.image:
            return self.image.file.content_type
        return ''

    # data validation
    def clean(self):
        # check if file is less than 5MB
        if self.image:
            if self.image.size > 5242880:
                raise ValidationError("File is too large")

    def __str__(self):
        return f"{self.message.user} sent an attachment at {self.message.created_at.strftime('%Y-%m-%d %H:%M:%S')}"