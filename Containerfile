FROM homeassistant/home-assistant:0.118.2

ENV LD_PRELOAD="/usr/local/lib/libjemalloc.so.2"

RUN apk update \
    && apk add tmux \
    && apk add --no-cache --virtual .build-deps gcc python3-dev musl-dev libffi-dev \
    && pip3 install keyring keyrings.cryptfile \
    && adduser --home /config --uid 1000 --disabled-password hass \
    && apk del .build-deps \
    && sed '/^exec.*/i s6-setuidgid hass' -i /etc/services.d/home-assistant/run # Run as hass user

COPY root /
