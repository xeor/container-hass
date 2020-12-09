FROM homeassistant/home-assistant:0.118.2

RUN apk update \
    && apk add tmux gnupg \
    && adduser --home /config --uid 1000 --disabled-password hass \
    && sed -e 's/^exec\(.*\)/s6-setuidgid hass\1/' -e '/^s6-setuidgid/a rm -f /config/secrets.yaml' -e '/^s6-setuidgid/i /usr/bin/secret_decrypt' -i /etc/services.d/home-assistant/run

COPY root /
