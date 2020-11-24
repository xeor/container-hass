# home-assistant container with some customs

* Run hass as its own user
* Start hass with encrypted secrets
* Secret-file are deleted when hass starts
* Container dies if hass crashes

## Security - encrypted secrets

The secrets are encrypted using a key that is only visible when home-assistant is starting. We do this by

* We use keyring and keyrings.cryptfile to store the secrets encrypted in a file.
* The password to open the cryptfile is read from `/etc/init-secrets/cryptfile_pw` when home-assistant starts.
  * The file is deleted once read
  * It is upto you to create a way for it to be populated at container-startup. You can example use k8s initcontainers for this, read secret from A, copy to B, then make sure the home-assistant container can only read (and delete) B.
* Container doesnt have SYS_PTRACE capability (as default), so debuggers can't attach to the running python program and get the secret. Only home-assistant can.

## Add encrypted secret

* hass -c /config --script keyring set something
