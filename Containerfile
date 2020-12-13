FROM homeassistant/home-assistant:0.118.5

RUN apk update \
    && apk add tmux gnupg \
    && adduser --home /config --uid 1000 --disabled-password hass \
    && sed 's/^exec\(.*\)/s6-setuidgid hass\1/' -i /etc/services.d/home-assistant/run

COPY root /
