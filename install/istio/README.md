```shell
istioctl install -y -n istio-system -f control-plane.yaml --revision 1-11-5
kubectl exec -n istio-system deploy/istiod-1-11-5 -- pilot-discovery request GET /debug/registryz
k label namespace default istio.io/rev=1-11-5
k apply -f labs/01/httpbin.yaml
k rollout restart deployment httpbin
```

Istiod:
- xDS server Envoy Config
- Service discovery
- Sidecar inject webhook
- Certificate authority

```shell
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prom prometheus-community/kube-prometheus-stack --version 14.3.0 -n prometheus -f labs/03/prom-values.yaml
kubectl get po -n prometheus
kubectl -n prometheus port-forward statefulset/prometheus-prom-kube-prometheus-stack-prometheus 9090 --address 0.0.0.0
kubectl -n prometheus create cm istio-dashboards \
--from-file=pilot-dashboard.json=labs/03/dashboards/pilot-dashboard.json \
--from-file=istio-workload-dashboard.json=labs/03/dashboards/istio-workload-dashboard.json \
--from-file=istio-service-dashboard.json=labs/03/dashboards/istio-service-dashboard.json \
--from-file=istio-performance-dashboard.json=labs/03/dashboards/istio-performance-dashboard.json \
--from-file=istio-mesh-dashboard.json=labs/03/dashboards/istio-mesh-dashboard.json \
--from-file=istio-extension-dashboard.json=labs/03/dashboards/istio-extension-dashboard.json
kubectl label -n prometheus cm istio-dashboards grafana_dashboard=1
kubectl -n prometheus port-forward svc/prom-grafana 3000:80 --address 0.0.0.0
kubectl apply -f labs/03/monitor-control-plane.yaml
kubectl apply -f labs/03/monitor-data-plane.yaml
for i in {1..10}; do kubectl exec deploy/sleep -n default -- curl http://httpbin.default:8000/headers; done
kubectl create ns kiali-operator
helm install \
--set cr.create=true \
--set cr.namespace=istio-system \
--namespace kiali-operator \
--repo https://kiali.org/helm-charts \
--version 1.40 \
kiali-operator \
kiali-operator
kubectl create serviceaccount kiali-dashboard -n istio-system
kubectl create clusterrolebinding kiali-dashboard-admin --clusterrole=cluster-admin --serviceaccount=istio-system:kiali-dashboard
kubectl get secret -n istio-system -o jsonpath="{.data.token}" $(kubectl get secret -n istio-system | grep kiali-dashboard | awk '{print $1}' ) | base64 --decode
```

## Istio Ingress Installation
```shell
kubectl create namespace istio-ingress
istioctl install -y -n istio-ingress -f labs/04/ingress-gateways.yaml --revision 1-11-5

```