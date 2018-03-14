#
# https://docs.docker.com/engine/reference/builder/
#
# https://hub.docker.com/_/python/
FROM python:3.5-alpine

RUN set -ex \
    && apk add --no-cache git nodejs \
    && npm install -g npm

RUN set -ex \
    && python --version \
    && node --version \
    && npm --version

RUN set -ex \
    && mkdir ~/pybee \
    && cd ~/pybee \
    && git clone --depth=5 https://github.com/pybee/batavia.git \
    && cd ~/pybee/batavia \
    && pip install -e . \
    && npm install \
    && npm run build


WORKDIR ~/pybee/batavia

RUN set -ex \
    && cd ~/pybee/batavia/testserver \
    && pip3 install -r requirements.txt

ENTRYPOINT ./manage.py --help