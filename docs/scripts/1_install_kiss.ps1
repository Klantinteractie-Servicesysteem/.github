$env = "dev"
$cert = "__$env-kiss-demo_nl.crt"
$key = "kiss-$env-private.key"
$namespace = "kiss-namespace"

kubectl create namespace $namespace

kubectl config current-context

kubectl config set-context --current --namespace=kiss-namespace
kubectl create secret tls --cert $cert --key=$key wildcard-kiss-tls -n $namespace
kubectl create secret generic kvk-certs --from-file=./kvk-certs

# Add helm repos
helm repo add elastic-repo https://helm.elastic.co
helm repo add ingress-nginx-repo https://kubernetes.github.io/ingress-nginx
helm repo add kiss-repo-ci https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/KISS-frontend/main/helm

# Install helm charts
helm repo update
helm upgrade --install --namespace kiss-namespace ingress-nginx-release ingress-nginx-repo/ingress-nginx --version 4.4.2 `
 --set controller.service.externalTrafficPolicy=Local --set annotations.nginx.ingress.kubernetes.io/proxy-buffer-size=16k
helm upgrade --install eck-operator elastic-repo/eck-operator --version 2.5.0

helm upgrade --install kiss-ci-release kiss-repo-ci/kiss-frontend --version 1.0.35 `
--values [local dir]\kiss.template.yaml `
--set elasticstack.credentials.password=[password], `
env.HAAL_CENTRAAL_API_KEY=[apikey], `
env.POSTGRES_PASSWORD=[db_pass], `
env.OIDC_CLIENT_ID=f73cab23-1291-40c3-b2ba-263634ddd262, `
env.OIDC_AUTHORITY=https://login.microsoftonline.com/0571c846-217a-43f0-baa6-a9f8a19865a8/v2.0, `
env.KVK_BASE_URL=https://api.kvk.nl/test/api/v1, `
env.KVK_API_KEY=l7xx1f2691f2520d487b902f4e0b57a0b197, `
env.HAAL_CENTRAAL_BASE_URL=https://proefomgeving.haalcentraal.nl/haalcentraal/api, `
env.POSTGRES_USER=kiss.bff, `
env.POSTGRES_DB=kiss.bff
