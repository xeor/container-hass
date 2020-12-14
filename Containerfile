FROM homeassistant/home-assistant:2020.12.0

RUN apk update \
    && apk add gnupg \
    && adduser --home /config --uid 1000 --disabled-password hass \
    && sed 's/^exec\(.*\)/s6-setuidgid hass\1/' -i /etc/services.d/home-assistant/run

COPY root /
