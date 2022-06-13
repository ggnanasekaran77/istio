#!/bin/bash

version=$1

cp vsvc-reviews-${version}.yaml vsvc-reviews.yaml

kubectl apply -f vsvc-reviews.yaml

end=$((SECONDS+120))

while [ $SECONDS -lt $end ]; do
    curl -ks -HHost:bookinfo.com http://34.87.99.92/productpage >/dev/null
done




