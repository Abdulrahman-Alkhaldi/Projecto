# import 
from rest_framework import serializers
from .models import *
# create a serializers
'''. You need to provide these in at least one serializer, try to do it whenever it is 
applicable.: 
i. Computed field based on a method -> in messages to see how many reports it has [DONE]
ii. Related field as a primary key -> in user_settings to get the user id  [DONE]
iii. Related field as a string -> in ReportedContent to get the reported message [DONE]
iv. Related filed as hyperlink -> in user to get the user settings   [DONE]
v. Related field as nested object -> in message to see who sent the message [DONE]
'''
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'email', 'created_at', 'user_settings']
    user_settings = serializers.HyperlinkedRelatedField(view_name='usersettings-detail', read_only=True)

    def create(self, validated_data):
        user = User.objects.create(**validated_data)
        user_settings = UserSettings.objects.create(user=user)
        user.user_settings = user_settings
        user.save()
        return user

    def update(self, instance, validated_data):
        instance.first_name = validated_data.get('first_name', instance.first_name)
        instance.last_name = validated_data.get('last_name', instance.last_name)
        instance.email = validated_data.get('email', instance.email)
        instance.save()

        if not hasattr(instance, 'user_settings'):
            user_settings = UserSettings.objects.create(user=instance)
            instance.user_settings = user_settings
            instance.save()

        return instance

class UserSettingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserSettings
        fields = ['id', 'theme', 'notifications', 'user']
        read_only_fields = ['user']

class NestedAttachmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Attachment
        fields = ['id', 'image', 'message']
        read_only_fields = ['message']


class AttachmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Attachment
        fields = ['id', 'image', 'message']
        
class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = ['id', 'content', 'created_at', 'user', 'number_of_reports','attachments']
    # nested object
    user = UserSerializer(read_only=True)
    attachments = AttachmentSerializer(many=True, read_only=True)
    # computed field
    number_of_reports = serializers.SerializerMethodField(method_name='get_number_of_reports')
    def get_number_of_reports(self, message):
        return message.reportedcontent_set.count()

class ReportedContentCreateSerializer(serializers.ModelSerializer):
    message = serializers.PrimaryKeyRelatedField(queryset=Message.objects.all())
    class Meta:
        model = ReportedContent
        fields = ['id', 'reason', 'status', 'created_at', 'reported_by', 'message']
        read_only_fields = ['status']


class ReportedContentSerializer(serializers.ModelSerializer):
    message = serializers.StringRelatedField()
    class Meta:
        model = ReportedContent
        fields = ['id', 'reason', 'status', 'created_at', 'reported_by', 'message']
        read_only_fields = ['status', 'reported_by']
        


