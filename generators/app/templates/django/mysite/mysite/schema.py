from graphene_django import DjangoObjectType
from graphene_django.filter import DjangoFilterConnectionField
from graphene_django.rest_framework.mutation import SerializerMutation
from graphene.relay import Node
from graphene import ObjectType, Schema
from rest_framework import serializers

from django.contrib.auth.models import User


class UserNode(DjangoObjectType):
    class Meta:
        model = User
        filter_fields = ['username', 'email']
        interfaces = (Node, )


class Query(ObjectType):
    user = Node.Field(UserNode)
    all_users = DjangoFilterConnectionField(UserNode)


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'email')


class UserMutation(SerializerMutation):
    class Meta:
        serializer_class = UserSerializer


class Mutation(ObjectType):
    user = UserMutation.Field()


schema = Schema(query=Query, mutation=Mutation)
