FROM alpine:3.10

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

RUN \
    apk add bash \
    && apk add bash-completion \
    && pip3 install --trusted-host pypi.python.org -r requirements.txt

CMD ["python3", "app.py"]

