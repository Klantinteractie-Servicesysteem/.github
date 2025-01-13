$env = "dev"
$cert = "__$env-kiss-demo_nl.crt"
$key = "kiss-$env-private.key"
$namespace = "kiss-namespace"
$kibanaHost = "kibana.dev.kiss-demo.nl"

kubectl create namespace $namespace
kubectl config current-context
kubectl config set-context --current --namespace=$namespace

# Add helm repos
helm repo add ingress-nginx-repo https://kubernetes.github.io/ingress-nginx
helm repo add kiss-repo-ci https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/KISS-frontend/main/helm
helm repo add kiss-elastic https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/main/docs/scripts/elastic
helm repo update

# Install nginx ingress
helm upgrade --install --namespace kiss-namespace ingress-nginx-release ingress-nginx-repo/ingress-nginx `
 --set controller.service.externalTrafficPolicy=Local --set annotations.nginx.ingress.kubernetes.io/proxy-buffer-size=16k

# Create TLS secret
kubectl create secret tls --cert $cert --key=$key wildcard-kiss-tls -n $namespace

# Install elastic components
kubectl create -f https://download.elastic.co/downloads/eck/2.9.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.9.0/operator.yaml
helm upgrade --set kibanaDomain=$kibanaHost --install kiss-elastic kiss-elastic/kiss-elastic --version 0.1.0

$POSTGRES_PASSWORD = 'ChangeThis'
$ELASTIC_PASSWORD = kubectl get secret kiss-es-elastic-user -o go-template='{{.data.elastic | base64decode }}'

# Add config
kubectl create configmap kiss-config `
    --from-literal=AFDELINGEN_BASE_URL=$(AFDELINGEN_BASE_URL) `
    --from-literal=AFDELINGEN_OBJECT_TYPE_URL=$(AFDELINGEN_OBJECT_TYPE_URL) `
    --from-literal=ASPNETCORE_ENVIRONMENT=$(ASPNETCORE_ENVIRONMENT) `
    --from-literal=CONTACTMOMENTEN_API_CLIENT_ID=$(CONTACTMOMENTEN_API_CLIENT_ID) `
    --from-literal=CONTACTMOMENTEN_BASE_URL=$(CONTACTMOMENTEN_BASE_URL) `
    --from-literal=ELASTIC_BASE_URL=$(ELASTIC_BASE_URL) `
    --from-literal=ELASTIC_USERNAME=$(ELASTIC_USERNAME) `
    --from-literal=EMAIL_ENABLE_SSL=$(EMAIL_ENABLE_SSL) `
    --from-literal=EMAIL_HOST=$(EMAIL_HOST) `
    --from-literal=EMAIL_PORT=$(EMAIL_PORT) `
    --from-literal=EMAIL_USERNAME=$(EMAIL_USERNAME) `
    --from-literal=ENTERPRISE_SEARCH_BASE_URL=$(ENTERPRISE_SEARCH_BASE_URL) `
    --from-literal=ENTERPRISE_SEARCH_ENGINE=$(ENTERPRISE_SEARCH_ENGINE) `
    --from-literal=FEEDBACK_EMAIL_FROM=$(FEEDBACK_EMAIL_FROM) `
    --from-literal=FEEDBACK_EMAIL_TO=$(FEEDBACK_EMAIL_TO) `
    --from-literal=GROEPEN_BASE_URL=$(GROEPEN_BASE_URL) `
    --from-literal=GROEPEN_OBJECT_TYPE_URL=$(GROEPEN_OBJECT_TYPE_URL) `
    --from-literal=HAAL_CENTRAAL_BASE_URL=$(HAAL_CENTRAAL_BASE_URL) `
    --from-literal=INTERNE_TAAK_BASE_URL=$(INTERNE_TAAK_BASE_URL) `
    --from-literal=INTERNE_TAAK_OBJECT_TYPE_URL=$(INTERNE_TAAK_OBJECT_TYPE_URL) `
    --from-literal=KLANTEN_BASE_URL=$(KLANTEN_BASE_URL) `
    --from-literal=KLANTEN_CLIENT_ID=$(KLANTEN_CLIENT_ID) `
    --from-literal=KLANTINTERACTIES_BASE_URL=$(KLANTINTERACTIES_BASE_URL) `
    --from-literal=KVK_BASE_URL=$(KVK_BASE_URL) `
    --from-literal=MEDEWERKER_OBJECTEN_BASE_URL=$(MEDEWERKER_OBJECTEN_BASE_URL) `
    --from-literal=MEDEWERKER_OBJECTTYPES_BASE_URL=$(MEDEWERKER_OBJECTTYPES_BASE_URL) `
    --from-literal=OIDC_AUTHORITY=$(OIDC_AUTHORITY) `
    --from-literal=OIDC_CLIENT_ID=$(OIDC_CLIENT_ID) `
    --from-literal=OIDC_MEDEWERKER_IDENTIFICATIE_CLAIM=$(OIDC_MEDEWERKER_IDENTIFICATIE_CLAIM) `
    --from-literal=OIDC_MEDEWERKER_IDENTIFICATIE_TRUNCATE=$(OIDC_MEDEWERKER_IDENTIFICATIE_TRUNCATE) `
    --from-literal=ORGANISATIE_IDS=$(ORGANISATIE_IDS) `
    --from-literal=POSTGRES_DB=$(POSTGRES_DB) `
    --from-literal=POSTGRES_HOST=$(POSTGRES_HOST) `
    --from-literal=POSTGRES_USER=$(POSTGRES_USER) `
    --from-literal=SDG_BASE_URL=$(SDG_BASE_URL) `
    --from-literal=SDG_OBJECTEN_BASE_URL=$(SDG_OBJECTEN_BASE_URL) `
    --from-literal=SDG_OBJECT_TYPE_URL=$(SDG_OBJECT_TYPE_URL) `
    --from-literal=VAC_OBJECTEN_BASE_URL=$(VAC_OBJECTEN_BASE_URL) `
    --from-literal=VAC_OBJECTTYPES_BASE_URL=$(VAC_OBJECTTYPES_BASE_URL) `
    --from-literal=ZAAKSYSTEEM__0__API_CLIENT_ID=$(ZAAKSYSTEEM__0__API_CLIENT_ID) `
    --from-literal=ZAAKSYSTEEM__0__BASE_URL=$(ZAAKSYSTEEM__0__BASE_URL) `
    --from-literal=ZAAKSYSTEEM__0__DEEPLINK_URL=$(ZAAKSYSTEEM__0__DEEPLINK_URL) `
    --from-literal=ZAAKSYSTEEM__0__DEEPLINK_PROPERTY=$(ZAAKSYSTEEM__0__DEEPLINK_PROPERTY) `
    --from-literal=ZAAKSYSTEEM__0__NIETNATUURLIJKPERSOONIDENTIFIER=$(ZAAKSYSTEEM__0__NIETNATUURLIJKPERSOONIDENTIFIER) `
    --from-literal=USE_KLANTINTERACTIES=$(USE_KLANTINTERACTIES) `
    --dry-run=client -o yaml | kubectl apply -f -

# Add secrets
kubectl create secret generic kiss-secrets `
    --from-literal=AFDELINGEN_TOKEN=$(AFDELINGEN_TOKEN) `
    --from-literal=CONTACTMOMENTEN_API_KEY=$(CONTACTMOMENTEN_API_KEY) `
    --from-literal=ELASTIC_PASSWORD=$ELASTIC_PASSWORD `
    --from-literal=EMAIL_PASSWORD=$(EMAIL_PASSWORD) `
    --from-literal=ENTERPRISE_SEARCH_PRIVATE_API_KEY=$(ENTERPRISE_SEARCH_PRIVATE_API_KEY) `
    --from-literal=ENTERPRISE_SEARCH_PUBLIC_API_KEY=$(ENTERPRISE_SEARCH_PUBLIC_API_KEY) `
    --from-literal=GROEPEN_TOKEN=$(GROEPEN_TOKEN) `
    --from-literal=HAAL_CENTRAAL_API_KEY=$(HAAL_CENTRAAL_API_KEY) `
    --from-literal=INTERNE_TAAK_TOKEN=$(INTERNE_TAAK_TOKEN) `
    --from-literal=KLANTEN_CLIENT_SECRET=$(KLANTEN_CLIENT_SECRET) `
    --from-literal=KLANTINTERACTIES_TOKEN=$(KLANTINTERACTIES_TOKEN) `
    --from-literal=KVK_API_KEY=$(KVK_API_KEY) `
    --from-literal=MEDEWERKER_OBJECTEN_TOKEN=$(MEDEWERKER_OBJECTEN_TOKEN) `
    --from-literal=MEDEWERKER_OBJECTTYPES_TOKEN=$(MEDEWERKER_OBJECTTYPES_TOKEN) `
    --from-literal=OIDC_CLIENT_SECRET=$(OIDC_CLIENT_SECRET) `
    --from-literal=POSTGRES_PASSWORD=$POSTGRES_PASSWORD `
    --from-literal=SDG_OBJECTEN_TOKEN=$(SDG_OBJECTEN_TOKEN) `
    --from-literal=VAC_OBJECTEN_TOKEN=$(VAC_OBJECTEN_TOKEN) `
    --from-literal=VAC_OBJECTTYPES_TOKEN=$(VAC_OBJECTTYPES_TOKEN) `
    --from-literal=ZAAKSYSTEEM__0__API_KEY=$(ZAAKSYSTEEM__0__API_KEY) `
    --from-literal=MANAGEMENTINFORMATIE_API_KEY=$(MANAGEMENTINFORMATIE_API_KEY) `
    --dry-run=client -o yaml | kubectl apply -f -

helm upgrade --install kiss-ci-release kiss-repo-ci/kiss-frontend --version 1.0.51 `
    --values [local dir]\kiss.template.yaml `
    --set image.tag='latest' `
    --set global.postgresql.auth.username='kiss.bff' `
    --set global.postgresql.auth.password=$POSTGRES_PASSWORD `
    --set global.postgresql.auth.database='kiss.bff' `
    --set global.postgresql.auth.postgresPassword=$POSTGRES_PASSWORD
