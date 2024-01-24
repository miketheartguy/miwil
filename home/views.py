from django.shortcuts import render

from .models import SocialLink


def index(request):
    links = SocialLink.objects.order_by("sequence", "id")
    context = {"links": links}
    return render(request, "home/index.html", context=context)
