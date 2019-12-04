from django.urls import path

from django.conf.urls import url, include
from .views import BaseApp

urlpatterns = [
    path("", BaseApp.as_view(), name="base"),
]
