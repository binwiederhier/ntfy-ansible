# aptly

Sets up an aptly repository.

## Generate GPG keys for the secrets

Generate and import key:
```
echo -e '%no-protection\nKey-Type: RSA\nKey-Length: 4096\nSubkey-Type: RSA\nExpire-Date: 0\nName-Real: ntfy LLC\nName-Email: ntfy@heckel.io\n%commit' > genkey.conf
gpg --batch --generate-key genkey.conf
```

Identify key with `gpg --list-keys`, and export it:

```
gpg --armor --export 55BA774A6F5EE67431E4B6B7CFDB962D4F1EC4AF > ntfy-pubkey.asc
gpg --armor --export-secret-keys 55BA774A6F5EE67431E4B6B7CFDB962D4F1EC4AF > ntfy-privkey.asc
gpg --export 55BA774A6F5EE67431E4B6B7CFDB962D4F1EC4AF > ntfy-keyring.gpg
```
