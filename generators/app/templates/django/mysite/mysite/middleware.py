import re

from django.conf import settings
from django.contrib.auth.decorators import login_required

from whitenoise.middleware import WhiteNoiseMiddleware


class IndexWhiteNoise(WhiteNoiseMiddleware):
    """Adds support for serving index pages for directory paths."""

    INDEX_NAME = 'static/index.html'

    def update_files_dictionary(self, *args):
        super(IndexWhiteNoise, self).update_files_dictionary(*args)
        #import ipdb; ipdb.set_trace()
        index_page_suffix = '/' + self.INDEX_NAME
        index_name_length = len(self.INDEX_NAME)
        directory_indexes = {}
        for url, static_file in self.files.items():
            if url.endswith(index_page_suffix):
                # For each index file found, add a corresponding URL->content mapping
                # for the file's parent directory, so that the index page is served for
                # the bare directory URL ending in '/'.
                parent_directory_url = url[:-index_name_length]
                directory_indexes[parent_directory_url] = static_file
        self.files.update(directory_indexes)

    def find_file(self, url):
        # In debug mode, find_file() is used to serve files directly from the filesystem
        # instead of using the list in `self.files`, so we append the index filename so
        # that will be served if present.
        if url.endswith('/'):
            url += self.INDEX_NAME
        return super(IndexWhiteNoise, self).find_file(url)

class RequireLoginMiddleware(object):
    """
    Middleware component that wraps the login_required decorator around
    matching URL patterns. To use, add the class to MIDDLEWARE_CLASSES and
    define LOGIN_REQUIRED_URLS and LOGIN_REQUIRED_URLS_EXCEPTIONS in your
    settings.py. For example:
    ------
    LOGIN_REQUIRED_URLS = (
        r'/topsecret/(.*)$',
    )
    LOGIN_REQUIRED_URLS_EXCEPTIONS = (
        r'/topsecret/login(.*)$',
        r'/topsecret/logout(.*)$',
    )
    ------
    LOGIN_REQUIRED_URLS is where you define URL patterns; each pattern must
    be a valid regex.

    LOGIN_REQUIRED_URLS_EXCEPTIONS is, conversely, where you explicitly
    define any exceptions (like login and logout URLs).
    """
    def __init__(self):
        self.required = tuple(re.compile(url) for url in settings.LOGIN_REQUIRED_URLS)
        self.exceptions = tuple(re.compile(url) for url in settings.LOGIN_REQUIRED_URLS_EXCEPTIONS)

    def process_view(self, request, view_func, view_args, view_kwargs):
        # No need to process URLs if user already logged in
        if request.user.is_authenticated():
            return None

        # An exception match should immediately return None
        for url in self.exceptions:
            if url.match(request.path):
                return None

        # Requests matching a restricted URL pattern are returned
        # wrapped with the login_required decorator
        for url in self.required:
            if url.match(request.path):
                return login_required(view_func)(request, *view_args, **view_kwargs)

        # Explicitly return None for all non-matching requests
        return None
