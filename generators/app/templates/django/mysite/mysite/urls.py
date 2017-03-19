"""posterbat URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""

from django.conf.urls import include, url
from django.contrib import admin
from django.conf.urls.static import static
from django.views.generic import RedirectView
from django.conf import settings

admin.autodiscover()

urlpatterns = [

    # static files (*.css, *.js, *.jpg etc.) served on /
    url(r'^(?!/?static/)(?!/?media/)(?P<path>.*\..*)$',
        RedirectView.as_view(url='/static/%(path)s', permanent=False)),

    # other views still work too
    url(r'^admin/', include(admin.site.urls)),
]

if settings.DEPLOYMENT == 'dev':
  urlpatterns = urlpatterns + static(
      settings.MEDIA_URL,
      document_root=settings.MEDIA_ROOT
  )

if settings.DEBUG:
    import debug_toolbar
    urlpatterns += [
        url(r'^__debug__/', include(debug_toolbar.urls)),
    ]
