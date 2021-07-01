gcloud container clusters get-credentials terraform-k8s-demo --zone us-west1-b

./get_helm.sh

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install my-release ingress-nginx/ingress-nginx

kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.11/deploy/manifests/00-crds.yaml

kubectl create namespace cert-manager

helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install \
  cert-manager \
  --namespace cert-manager \
  --version v0.11.0 \
  jetstack/cert-manager

kubectl apply -f k8s
sleep 1m
kubectl apply -f k8s/letsencrypt