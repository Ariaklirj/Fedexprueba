FROM python:3.7-alpine

ENV TZ=America/Mexico_City

RUN \
    apk update && \
    apk upgrade

  RUN apk --no-cache add \
      g++ \
      bash \
      build-base \
      curl \
      gcc \
      gettext \
      libffi-dev \
      linux-headers \
      musl-dev \
      postgresql-dev \
      postgresql-libs \
      tini \
      jpeg-dev \
      zlib-dev \
      python-dev \
      libxml2 \
      libxml2-dev && \
      apk add libxslt-dev

RUN \
    pip3 install -U pip setuptools pipenv psycopg2-binary uwsgi && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

WORKDIR /usr/src/app/

COPY Pipfile .

COPY Pipfile.lock .

RUN pipenv install --deploy --system

COPY . /usr/src/app/

CMD ["uwsgi", "--http-socket", ":8000", "--py-autoreload", "1", "--module", "srenvio.wsgi:application"]
