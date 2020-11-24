# home-assistant container with some customs

* Run hass as its own user
* Start hass with encrypted secrets
* Secret-file are deleted when hass starts
* Container dies if hass crashes

## encrypted secret

* hass -c /config --script keyring set something
