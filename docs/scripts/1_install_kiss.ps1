$ns = "kiss-bundle"
$gw = "klantinteractie-servicesysteem-gateway"
$env = "accept"
$domain = "kiss-demo.nl"

$cert = "__$env-kiss-demo_nl.crt"
$key = "kiss-$env-private.key"

$gatewayPassword = "[!ChangeMe!]"

kubectl create namespace $ns
kubectl create namespace kiss-wordpress
kubectl config set-context --current --namespace=$ns
kubectl create secret tls --cert $cert --key=$key wildcard-kiss-tls -n kiss-wordpress
kubectl create secret tls --cert $cert --key=$key wildcard-kiss-tls -n kiss-bundle



# Add helm repos
helm repo add cert-manager https://charts.jetstack.io
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add elastic https://helm.elastic.co
helm repo add kvaps https://kvaps.github.io/charts
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add klantinteractie-servicesysteem https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/KISS-frontend/main/helm
helm repo add user-component https://raw.githubusercontent.com/ConductionNL/user-component/master/api/helm/
helm repo add bitnami https://charts.bitnami.com/bitnami

# Install helm charts
helm repo update
helm install ingress-nginx --namespace kiss-ingress ingress-nginx/ingress-nginx --create-namespace --version 4.4.2 --set controller.service.externalTrafficPolicy=Local
helm install cert-manager --namespace kiss-haven --version v1.10.1 cert-manager/cert-manager --create-namespace --set installCRDs=true
helm install loki --namespace kiss-haven --version 3.8.0 loki/loki --set installCRDs=true
helm install eck-operator elastic/eck-operator --namespace kiss-elastic --create-namespace --version 2.5.0
helm install nfs-server-provisioner --namespace kiss-haven kvaps/nfs-server-provisioner  --create-namespace --version 1.4.0

Write-Output "Timeout zodat nginx tijd heeft om ready te worden, dit endpoint is nodig voor de kiss-frontend"
timeout 30
helm upgrade --install klantinteractie-servicesysteem --namespace $ns --version 1.0.17 klantinteractie-servicesysteem/kiss-frontend -f /yaml/kiss-$env.yaml
helm upgrade --install user-component --namespace $ns user-component/user-component -f /yaml/user-component-$env.yaml
helm install wordpress --namespace kiss-wordpress bitnami/wordpress --version 15.2.24 --create-namespace -f /yaml/wordpress-$env.yaml

Write-Output "Timeout zodat de gateway kan opkomen. als beide klantinteractie-servicesysteem-gateway pods up zijn, kan verder gegaan worden."
timeout 600
$gwPod = kubectl get pods --selector=app.kubernetes.io/name=gateway -o jsonpath='{.items[0].metadata.name}'
$gwPod2 = kubectl get pods --selector=app.kubernetes.io/name=gateway -o jsonpath='{.items[1].metadata.name}'
$ucPod = kubectl get pods --selector=app.kubernetes.io/name=user-component -o jsonpath='{.items[0].metadata.name}'

#Update schema's
kubectl exec --stdin --tty --namespace $ns $gwPod -c $gw-php -- bin/console doctrine:schema:update -f
kubectl exec --stdin --tty --namespace $ns $ucPod -c user-component-php -- bin/console doctrine:schema:update -f
kubectl exec --stdin --tty --namespace $ns $ucPod -c user-component-php -- bin/console hautelook:fixtures:load -n

#Add gateway authentication
Import-Module PostgreSQLCmdlets
Start-Process kubectl 'port-forward klantinteractie-servicesysteem-postgresql-0 5433:5432'
$sqlKiss = Connect-PostgreSQL  -User commonground-gateway -Password $gatewayPassword -Database commonground-gateway -Server localhost -Port 5433
Add-PostgreSQL -Connection $sqlKiss -Table authentication -Columns @("id", "name", "authenticate_url", "token_url", "secret", "client_id", "scopes") -Values @('c69c8f11-a470-4fc8-b3ed-58d67e966cab','dex', "https://$env.$domain/dex/auth", "https://$env.$domain/dex/token", '[!ChangeMe!]', 'kiss', 'a:4:{i:0;s:6:"openid";i:1;s:5:"email";i:2;s:6:"groups";i:3;s:7:"profile";}')

kubectl exec --stdin --tty -n $ns $gwPod -- bin/console commongateway:initialize -data
kubectl exec --stdin --tty -n $ns $gwPod -c klantinteractie-servicesysteem-gateway-php -- bin/console cache:clear
kubectl exec --stdin --tty -n $ns $gwPod2 -c klantinteractie-servicesysteem-gateway-php -- bin/console cache:clear

Write-Output "Klaar"