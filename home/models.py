from django.db import models
from martor.models import MartorField


# Create your models here.
class SocialLink(models.Model):
    url = models.URLField(unique=True)
    title = models.CharField(max_length=100)
    icon = models.CharField(max_length=100)
    sequence = models.IntegerField()
    description = MartorField(null=True, blank=True)
    banner = models.ImageField(null=True, blank=True)
