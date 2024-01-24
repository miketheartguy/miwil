ARG PYTHON_VERSION=3.10-slim-bullseye

FROM python:${PYTHON_VERSION}

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies.
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /code

WORKDIR /code

COPY requirements.txt manage.py /code/
COPY miwil /code/miwil
COPY home /code/home
COPY portfolio /code/portfolio

RUN pip install -r /code/requirements.txt

EXPOSE 8000

CMD ["gunicorn", "--bind", ":8000", "--workers", "2", "miwil.wsgi"]
