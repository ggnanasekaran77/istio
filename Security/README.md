## Openssl Commands
```shell
export DOMAIN_NAME=ggnanasekaran77.com
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=$DOMAIN_NAME Inc./CN=$DOMAIN_NAME' -keyout $DOMAIN_NAME.key -out $DOMAIN_NAME.crt
openssl req -out hello.$DOMAIN_NAME.csr -newkey rsa:2048 -nodes -keyout hello.$DOMAIN_NAME.key -subj "/CN=hello.$DOMAIN_NAME/O=hello from $DOMAIN_NAME"
openssl x509 -req -days 365 -CA $DOMAIN_NAME.crt -CAkey $DOMAIN_NAME.key -set_serial 0 -in hello.$DOMAIN_NAME -out hello.$DOMAIN_NAME.crt
```