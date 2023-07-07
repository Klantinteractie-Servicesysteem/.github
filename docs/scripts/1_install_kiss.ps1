$env = "dev"
$cert = "__$env-kiss-demo_nl.crt"
$key = "kiss-$env-private.key"
$namespace = "kiss-namespace"

kubectl create namespace $namespace

kubectl config current-context

kubectl config set-context --current --namespace=kiss-namespace
kubectl create secret tls --cert $cert --key=$key wildcard-kiss-tls -n $namespace

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
--set image.tag=$(imageTag), `
elasticstack.credentials.password=$(elasticPassword), `
env.OIDC_CLIENT_SECRET=$(oidcClientSecret), `
env.OIDC_CLIENT_ID=$(oidcClientId), `
env.OIDC_AUTHORITY=$(oidcAuthority), `
env.KVK_BASE_URL=$(kvkBaseUrl), `
env.KVK_API_KEY=$(kvkApiKey), `
env.HAAL_CENTRAAL_API_KEY=$(haalCentraalApiKey), `
env.HAAL_CENTRAAL_BASE_URL=$(haalCentraalBaseUrl), `
env.POSTGRES_PASSWORD=$(postgresPassword), `
env.POSTGRES_USER=$(postgresUser), `
env.POSTGRES_DB=$(postgresDb), `
env.ENTERPRISE_SEARCH_BASE_URL=$(enterprise_search_url), `
env.ENTERPRISE_SEARCH_PRIVATE_API_KEY=$(enterprise_search_private_api), `
env.ENTERPRISE_SEARCH_PUBLIC_API_KEY=$(enterprise_search_public_api), `
env.ZAKEN_BASE_URL=$(ZAKEN_BASE_URL), `
env.ZAKEN_API_KEY=$(ZAKEN_API_KEY), `
env.ZAKEN_API_CLIENT_ID=$(ZAKEN_API_CLIENT_ID), `
env.KLANTEN_BASE_URL=$(klanten_base_url), `
env.KLANTEN_CLIENT_ID=$(klanten_client_id), `
env.KLANTEN_CLIENT_SECRET=$(klanten_client_secret), `
env.EMAIL_HOST=$(EMAIL_HOST), `
env.EMAIL_PORT=$(EMAIL_PORT), `
env.EMAIL_USERNAME=$(EMAIL_USERNAME), `
env.EMAIL_PASSWORD=$(EMAIL_PASSWORD), `
env.EMAIL_ENABLE_SSL=$(EMAIL_ENABLE_SSL), `
env.FEEDBACK_EMAIL_FROM=$(FEEDBACK_EMAIL_FROM), `
env.FEEDBACK_EMAIL_TO=$(FEEDBACK_EMAIL_TO), `
env.CONTACTMOMENTEN_BASE_URL=$(CONTACTMOMENTEN_BASE_URL), `
env.CONTACTMOMENTEN_API_KEY=$(CONTACTMOMENTEN_API_KEY), `
env.CONTACTMOMENTEN_API_CLIENT_ID=$(CONTACTMOMENTEN_API_CLIENT_ID), `
env.OBJECTEN_BASE_URL=$(OBJECTEN_BASE_URL), `
env.OBJECTEN_TOKEN=$(OBJECTEN_TOKEN), `
env.OBJECTTYPES_BASE_URL=$(OBJECTTYPES_BASE_URL), `
env.OBJECTTYPES_TOKEN=$(OBJECTTYPES_TOKEN), `
env.SDG_BASE_URL=$(SDG_BASE_URL), `
env.SDG_API_KEY=$(SDG_API_KEY), `
global.postgresql.auth.username=$(postgresUser), `
global.postgresql.auth.password=$(postgresPassword), `
global.postgresql.auth.database=$(postgresDb), `
global.postgresql.auth.postgresPassword=$(postgresPassword)env.ORGANISATIE_IDS=$(ORGANISATIE_IDS)
