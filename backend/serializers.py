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
        fields = ['id', 'first_name', 'last_name', 'email', 'created_at','user_settings']
    # hyperlink
    user_settings = serializers.HyperlinkedRelatedField(view_name='usersettings-detail', read_only=True)


class UserSettingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserSettings
        fields = ['id', 'theme', 'notifications', 'user']

class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = ['id', 'content', 'created_at', 'user', 'number_of_reports']
    # nested object
    user = UserSerializer(read_only=True)
    # computed field
    number_of_reports = serializers.SerializerMethodField(method_name='get_number_of_reports')
    def get_number_of_reports(self, message):
        return message.reportedcontent_set.count()

class ReportedContentSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReportedContent
        fields = ['id', 'reason', 'status', 'created_at', 'reported_by', 'message']
    # related field as a string
    message = serializers.StringRelatedField()

# custom serializer
class CustomAttachmentSerializer(serializers.Serializer):
    id = serializers.IntegerField(read_only=True)
    image = serializers.ImageField()
    message = serializers.PrimaryKeyRelatedField(queryset=Message.objects.all())

    # creating a new object
    def create(self, validated_data):
        return Attachment.objects.create(**validated_data)
    
    # updating an existing object 
    def update(self, instance, validated_data):
        instance.image = validated_data.get('image', instance.image)
        instance.message = validated_data.get('message', instance.message)
        instance.save()
        return instance
    
