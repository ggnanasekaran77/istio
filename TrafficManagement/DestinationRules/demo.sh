#!/bin/bash

version=$1

cp vsvc-reviews-${version}.yaml vsvc-reviews.yaml

kubectl apply -f vsvc-reviews.yaml

end=$((SECONDS+120))

while [ $SECONDS -lt $end ]; do
    curl -ks -HHost:bookinfo.com http://$(kubectl -n istio-system get svc istio-ingressgateway --output jsonpath='{.status.loadBalancer.ingress[0].ip}')/productpage >/dev/null
done
