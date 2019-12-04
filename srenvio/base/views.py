from django.shortcuts import render
from django.http import HttpResponse
from rest_framework.views import APIView
from django.template import Context, loader


# Create your views here.
class BaseApp(APIView):
    def get(self, request):
        template = loader.get_template("index.html")
        return HttpResponse(template.render())
