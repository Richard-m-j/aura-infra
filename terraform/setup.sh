#!/bin/bash
set -e
 
sudo hostnamectl set-hostname master
 
sudo kubeadm init --cri-socket=unix:///var/run/crio/crio.sock
# Configure kubeconfig for ubuntu user
sudo mkdir -p /home/ubuntu/.kube
sudo cp /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
sudo chown ubuntu:ubuntu /home/ubuntu/.kube/config
# Install Weave Net CNI
sudo -u ubuntu kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
# Wait until node is Ready
echo "Waiting for node to become Ready..."
until sudo -u ubuntu kubectl get nodes | grep -q ' Ready '; do
    sleep 5
done
# Remove control-plane taint
sudo -u ubuntu kubectl taint node $(hostname) node-role.kubernetes.io/control-plane:NoSchedule- || true
# Wait for kube-system pods
echo "Waiting for kube-system pods to be Ready..."
until sudo -u ubuntu kubectl get pods -n kube-system | grep -Ev 'STATUS|Running' | wc -l | grep -q '^0$'; do
    sleep 5
done
echo "Kubernetes control-plane setup complete."

# kubectl apply -f https://raw.githubusercontent.com/vilasvarghese/docker-k8s/refs/heads/master/yaml/hpa/components.yaml

# echo "Installing metric server done"

# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.0/deploy/static/provider/baremetal/deploy.yaml

# sleep 10
# # Wait for controller to be ready
# kubectl wait --namespace ingress-nginx \
  # --for=condition=ready pod \
  # --selector=app.kubernetes.io/component=controller \
  # --timeout=180s

# # Patch ingress-nginx-controller service to use a specific NodePort for http
# kubectl patch service -n ingress-nginx ingress-nginx-controller --type='json' -p='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value":32000}]'


# echo "Installing ingress controller done"

# echo "Installing Argo CD"

# kubectl create namespace argocd

# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# # Wait for argocd-server to be ready
# kubectl wait --namespace argocd \
  # --for=condition=ready pod \
  # --selector=app.kubernetes.io/name=argocd-server \
  # --timeout=180s

# # Patch argocd-server service to be of type NodePort and use a specific port
# kubectl patch service -n argocd argocd-server -p '{"spec": {"type": "NodePort", "ports": [{"port": 80, "targetPort": 8080, "nodePort": 31000, "name": "http"}, {"port": 443, "targetPort": 8080, "nodePort": 31443, "name": "https"}]}}'

# echo "Installing Argo CD done"

# echo "Installing helm"

# curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
# chmod 700 get_helm.sh
# ./get_helm.sh

# sleep 30

# echo "Installing helm done"

# helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
# helm repo update

# echo "Adding Prometheus repo done"

# echo "Installing Prometheus"

# kubectl create ns monitoring

# helm install monitoring prometheus-community/kube-prometheus-stack \
# -n monitoring \
# -f prometheus-stack.yml

# sleep 30 

# echo "Installing Prometheus and Grafana done"

# kubectl apply -f root-app.yaml