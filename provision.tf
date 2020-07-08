resource "null_resource" "dd-install-exec" {
  //count = var.install_dd ? 1 : 0
  triggers = {
    kubernetes_cluster_kube_id = azurerm_kubernetes_cluster.default.id // module.eks-cluster.kubernetes_config_map_id
  }
  # Login for any kubetctl commands the user may want to perform
  provisioner "local-exec" {
    command = <<EOF
az aks get-credentials --resource-group ${azurerm_resource_group.default.name} --name ${azurerm_kubernetes_cluster.default.name}
EOF
  }
  provisioner "local-exec" {
    command = <<EOF
cd helm/kubernetes-helm-hello-world && helm install helloworld helloworld-chart-0.1.0.tgz
EOF
  }
  provisioner "local-exec" {
    command = <<EOF
    bash -c 'external_ip=""; while [ -z $external_ip ]; do echo "Waiting for end point..."; external_ip=$(kubectl get svc helloworld-helloworld-chart --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}"); [ -z "$external_ip" ] && sleep 10; done; echo "End point ready-" && echo $external_ip; export endpoint=$external_ip'
EOF
  }
}