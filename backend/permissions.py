from rest_framework.permissions import BasePermission
from rest_framework import permissions


class IsOwner(BasePermission):
    """
    Custom permission to check if the user is the owner of the object.
    """
    
    def has_object_permission(self, request, view, obj):
        return obj.user.id ==  request.user.user.id


# class CustomDjangoModelPermission(permissions.DjangoModelPermissions):
#     def __init__(self) -> None:
#         self.perms_map['GET'] = ['%(app_label)s.unsend_%(model_name)s']

class UnsendMessagePermission(BasePermission):
    """
    Custom permission to check if the user has permission to unsend a message.
    """
    def has_permission(self, request, view):
        print('s')
        if request.method == 'GET':
            return True
        if request.method == 'DELETE':
            return request.user.groups.filter(name='moderators').exists()
        return False