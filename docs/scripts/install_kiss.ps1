$env = "dev"
$cert = "__$env-kiss-demo_nl.crt"
$key = "kiss-$env-private.key"
$namespace = "kiss-namespace"

kubectl create namespace $namespace
kubectl config current-context
kubectl config set-context --current --namespace=$namespace

# Add helm repos
helm repo add ingress-nginx-repo https://kubernetes.github.io/ingress-nginx
helm repo add kiss-repo-ci https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/KISS-frontend/main/helm
helm repo update

# Install nginx ingress
helm upgrade --install --namespace kiss-namespace ingress-nginx-release ingress-nginx-repo/ingress-nginx `
 --set controller.service.externalTrafficPolicy=Local --set annotations.nginx.ingress.kubernetes.io/proxy-buffer-size=16k

 # create TLS secret
kubectl create secret tls --cert $cert --key=$key wildcard-kiss-tls -n $namespace

# Install elastic components
#Files are located at /elastic/eck/
#Update the kibana placeholders in the last 3 files.
kubectl create -f https://download.elastic.co/downloads/eck/2.9.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.9.0/operator.yaml
kubectl apply -f elasticsearch.yaml
kubectl apply -f kibana.yaml
kubectl apply -f kibana-ingress.yaml
kubectl apply -f enterprisesearch.yaml

$POSTGRES_PASSWORD = 'ChangeThis'
$ELASTIC_PASSWORD = kubectl get secret kiss-es-elastic-user -o go-template='{{.data.elastic | base64decode }}'

# Add config
kubectl create configmap kiss-config `
    --from-literal=ASPNETCORE_ENVIRONMENT=$(ASPNETCORE_ENVIRONMENT) `
    --from-literal=OIDC_CLIENT_ID=$(OIDC_CLIENT_ID) `
    --from-literal=OIDC_AUTHORITY=$(OIDC_AUTHORITY) `
    --from-literal=KVK_BASE_URL=$(KVK_BASE_URL) `
    --from-literal=HAAL_CENTRAAL_BASE_URL=$(HAAL_CENTRAAL_BASE_URL) `
    --from-literal=POSTGRES_USER=$(POSTGRES_USER) `
    --from-literal=POSTGRES_HOST=$(POSTGRES_HOST) `
    --from-literal=POSTGRES_DB=$(POSTGRES_DB) `
    --from-literal=ENTERPRISE_SEARCH_BASE_URL=$(ENTERPRISE_SEARCH_BASE_URL) `
    --from-literal=ENTERPRISE_SEARCH_ENGINE=$(ENTERPRISE_SEARCH_ENGINE) `
    --from-literal=ZAKEN_BASE_URL=$(ZAKEN_BASE_URL) `
    --from-literal=ZAKEN_API_CLIENT_ID=$(ZAKEN_API_CLIENT_ID) `
    --from-literal=KLANTEN_BASE_URL=$(KLANTEN_BASE_URL) `
    --from-literal=KLANTEN_CLIENT_ID=$(KLANTEN_CLIENT_ID) `
    --from-literal=EMAIL_HOST=$(EMAIL_HOST) `
    --from-literal=EMAIL_PORT=$(EMAIL_PORT) `
    --from-literal=EMAIL_USERNAME=$(EMAIL_USERNAME) `
    --from-literal=EMAIL_ENABLE_SSL=$(EMAIL_ENABLE_SSL) `
    --from-literal=FEEDBACK_EMAIL_FROM=$(FEEDBACK_EMAIL_FROM) `
    --from-literal=FEEDBACK_EMAIL_TO=$(FEEDBACK_EMAIL_TO) `
    --from-literal=CONTACTMOMENTEN_BASE_URL=$(CONTACTMOMENTEN_BASE_URL) `
    --from-literal=CONTACTMOMENTEN_API_CLIENT_ID=$(CONTACTMOMENTEN_API_CLIENT_ID) `
    --from-literal=SDG_BASE_URL=$(SDG_BASE_URL) `
    --from-literal=ORGANISATIE_IDS=$(ORGANISATIE_IDS) `
    --from-literal=MEDEWERKER_OBJECTEN_BASE_URL=$(MEDEWERKER_OBJECTEN_BASE_URL) `
    --from-literal=MEDEWERKER_OBJECTTYPES_BASE_URL=$(MEDEWERKER_OBJECTTYPES_BASE_URL) `
    --from-literal=VAC_OBJECTEN_BASE_URL=$(VAC_OBJECTEN_BASE_URL) `
    --from-literal=VAC_OBJECTTYPES_BASE_URL=$(VAC_OBJECTTYPES_BASE_URL) `
    --from-literal=INTERNE_TAAK_BASE_URL=$(INTERNE_TAAK_BASE_URL) `
    --from-literal=INTERNE_TAAK_OBJECT_TYPE_URL=$(INTERNE_TAAK_OBJECT_TYPE_URL) `
    --from-literal=AFDELINGEN_BASE_URL=$(AFDELINGEN_BASE_URL) `
    --from-literal=AFDELINGEN_OBJECT_TYPE_URL=$(AFDELINGEN_OBJECT_TYPE_URL) `
    --from-literal=GROEPEN_BASE_URL=$(GROEPEN_BASE_URL) `
    --from-literal=GROEPEN_OBJECT_TYPE_URL=$(GROEPEN_OBJECT_TYPE_URL) `
    --from-literal=ELASTIC_USERNAME=$(ELASTIC_USERNAME) `
    --from-literal=ELASTIC_BASE_URL=$(ELASTIC_BASE_URL) `
    --dry-run=client -o yaml | kubectl apply -f -
# Add secrets
kubectl create secret generic kiss-secrets `
    --from-literal=OIDC_CLIENT_SECRET=$(OIDC_CLIENT_SECRET) `
    --from-literal=KVK_API_KEY=$(KVK_API_KEY) `
    --from-literal=HAAL_CENTRAAL_API_KEY=$(HAAL_CENTRAAL_API_KEY) `
    --from-literal=POSTGRES_PASSWORD=$POSTGRES_PASSWORD `
    --from-literal=ENTERPRISE_SEARCH_PUBLIC_API_KEY=$(ENTERPRISE_SEARCH_PUBLIC_API_KEY) `
    --from-literal=ENTERPRISE_SEARCH_PRIVATE_API_KEY=$(ENTERPRISE_SEARCH_PRIVATE_API_KEY) `
    --from-literal=ZAKEN_API_KEY=$(ZAKEN_API_KEY) `
    --from-literal=KLANTEN_CLIENT_SECRET=$(KLANTEN_CLIENT_SECRET) `
    --from-literal=EMAIL_PASSWORD=$(EMAIL_PASSWORD) `
    --from-literal=CONTACTMOMENTEN_API_KEY=$(CONTACTMOMENTEN_API_KEY) `
    --from-literal=MEDEWERKER_OBJECTEN_TOKEN=$(MEDEWERKER_OBJECTEN_TOKEN) `
    --from-literal=MEDEWERKER_OBJECTTYPES_TOKEN=$(MEDEWERKER_OBJECTTYPES_TOKEN) `
    --from-literal=VAC_OBJECTEN_TOKEN=$(VAC_OBJECTEN_TOKEN) `
    --from-literal=VAC_OBJECTTYPES_TOKEN=$(VAC_OBJECTTYPES_TOKEN) `
    --from-literal=INTERNE_TAAK_TOKEN=$(INTERNE_TAAK_TOKEN) `
    --from-literal=AFDELINGEN_TOKEN=$(AFDELINGEN_TOKEN) `
    --from-literal=GROEPEN_TOKEN=$(GROEPEN_TOKEN) `
    --from-literal=ELASTIC_PASSWORD=$ELASTIC_PASSWORD `
    --dry-run=client -o yaml | kubectl apply -f -

kubectl create secret generic kiss-elastic-env `
    --from-literal=ENTERPRISE_SEARCH_BASE_URL=$(ENTERPRISE_SEARCH_BASE_URL) `
    --from-literal=ENTERPRISE_SEARCH_PRIVATE_API_KEY=$(ENTERPRISE_SEARCH_PRIVATE_API_KEY) `
    --from-literal=ENTERPRISE_SEARCH_ENGINE=$(ENTERPRISE_SEARCH_ENGINE) `
    --from-literal=SDG_OBJECTEN_BASE_URL=$(SDG_OBJECTEN_BASE_URL) `
    --from-literal=SDG_OBJECTEN_TOKEN=$(SDG_OBJECTEN_TOKEN) `
    --from-literal=SDG_OBJECT_TYPE_URL=$(SDG_OBJECT_TYPE_URL) `
    --from-literal=MEDEWERKER_OBJECTEN_BASE_URL=$(MEDEWERKER_OBJECTEN_BASE_URL) `
    --from-literal=MEDEWERKER_OBJECTTYPES_BASE_URL=$(MEDEWERKER_OBJECTTYPES_BASE_URL) `
    --from-literal=VAC_OBJECTEN_BASE_URL=$(VAC_OBJECTEN_BASE_URL) `
    --from-literal=VAC_OBJECTTYPES_BASE_URL=$(VAC_OBJECTTYPES_BASE_URL) `
    --from-literal=MEDEWERKER_OBJECTEN_TOKEN=$(MEDEWERKER_OBJECTEN_TOKEN) `
    --from-literal=MEDEWERKER_OBJECTTYPES_TOKEN=$(MEDEWERKER_OBJECTTYPES_TOKEN) `
    --from-literal=VAC_OBJECTEN_TOKEN=$(VAC_OBJECTEN_TOKEN) `
    --from-literal=VAC_OBJECTTYPES_TOKEN=$(VAC_OBJECTTYPES_TOKEN) `
    --from-literal=ELASTIC_USERNAME=$(ELASTIC_USERNAME) `
    --from-literal=ELASTIC_PASSWORD=$ELASTIC_PASSWORD `
    --from-literal=ELASTIC_BASE_URL=$(ELASTIC_BASE_URL) `
    --dry-run=client -o yaml | kubectl apply -f -

helm upgrade --install kiss-ci-release kiss-repo-ci/kiss-frontend --version 1.0.49 `
    --values [local dir]\kiss.template.yaml `
    --set image.tag='latest' `
    --set global.postgresql.auth.username='kiss.bff' `
    --set global.postgresql.auth.password=$POSTGRES_PASSWORD `
    --set global.postgresql.auth.database='kiss.bff' `
    --set global.postgresql.auth.postgresPassword=$POSTGRES_PASSWORD