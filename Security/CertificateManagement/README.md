```shell
make ../tools/certs/Makefile.selfsigned.mk root-ca
make ../tools/certs/Makefile.selfsigned.mk localcluster-cacerts
kubectl delete ns istio-system 
cd ..
./samples/bookinfo/platform/kube/cleanup.sh
kubectl create ns istio-system
kubectl create secret generic cacerts -n istio-system \
  --from-file=ca-cert.pem \
  -- from-file=ca-key.pem \
  --from-file=root-cert.pem \
  --from-file=cert-chain.pem
istioctl install --set profile=demo
kubectl apply -f samples/addons
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml
istioctl analyze
```

```shell
kubectl exec "$(kubectl get pods -l app=details -o jsonpath={.items.metadata.name})" -c istio-proxy -- openssl s_client -showcerts -connect productpage:9080 > httpbin-proxy-cert.txt
sed -ne '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/p' httpbin-proxy-cert.txt | sed > certs.pem 
split -p "-----BEGIN CERTIFICATE-----" certs.pem proxy-cert-
openssl x509 -in ca-certs/localcluster/root-cert.pem -text -noout > /tmp/root-cert.crt.txt
openssl x509 -in ./proxy-cert-3.pem -text -noout > /tmp/pod-root-cert.crt.txt
diff -s /tmp/root-cert.crt.txt /tmp/pod-root-cert.crt.txt
```

