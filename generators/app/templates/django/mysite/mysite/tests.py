from snapshottest.django import TestCase
from graphene.test import Client


class APITestCase(TestCase):
    def test_api_me(self):
        """Testing the API for /me"""
        my_api_response = api.client.get('/me')
        self.assertMatchSnapshot(my_api_response)
