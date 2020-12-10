# home-assistant container with some customs

* Run hass as its own user
* Start hass with encrypted secrets
* Secret-file are deleted when hass starts

## Security - encrypted secrets

The secrets are encrypted using a key that is only visible when home-assistant is starting. We do this by

* Using gpg to decrypt the secrets.yaml file right before home-assistant is stareted.
* The password is read from `/etc/init-secrets/secretfile_pw`
  * The file is deleted once decrypted
  * It is upto you to create a way for it to be populated at container-startup. You can example use k8s initcontainers for this, read secret from A, copy to B, then make sure the home-assistant container can only read (and delete) B.
* Container doesnt have SYS_PTRACE capability (as default), so debuggers can't attach to the running python program and get the secret. Only home-assistant can.
* Use `secret_decrypt` to manually decrypt, or `secret_encrypt` to encrypt it.. Set `DONT_DELETE_PWFILE=1` if you want to keep the secret pw file..

* To start using encryption, you can create the initial encrypted file with:
  * gpg --output /config/secrets.yaml.enc --symmetric --s2k-mode 3 --s2k-count 65011712 --s2k-digest-algo SHA512 --cipher-algo AES256 --no-symkey-cache --armor /config/secrets.yaml