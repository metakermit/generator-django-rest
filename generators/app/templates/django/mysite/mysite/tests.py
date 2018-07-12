from snapshottest.django import TestCase
#from graphene.test import Client
from django.test import Client


client = Client()

class APITestCase(TestCase):
    def test_api_index(self):
        """Testing the API for /graphql/"""
        my_api_response = client.get('/graphql/')
        self.assertMatchSnapshot(my_api_response)
