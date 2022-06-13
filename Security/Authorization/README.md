```shell
kubectl apply -f <(istioctl kube-inject -f samples/httpbin/httpbin.yaml) -n bar
kubectl exec -it "$(kubectl get pod -l app=httpbin -n bar -o jsonpath={.items.metadata.name})" -c istio-proxy -n bar -- curl "http://productpage.default:9080" -s -o /dev/null -w "%{http_code}\n"
```

```shell
kubectl apply -f allow-nothing.yaml
kubectl apply -f productpage-viewer.yaml
kubectl apply -f details-viewer.yaml
kubectl apply -f reviews-viewer.yaml
kubectl apply -f ratings-viewer.yaml
```