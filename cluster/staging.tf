/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
locals {
cluster_type_1 = "simple-autopilot-public-1"
network_name_1 = "simple-autopilot-public-network-1"
subnet_name_1 = "simple-autopilot-public-subnet-1"
master_auth_subnetwork_1 = "simple-autopilot-public-master-subnet-1"
pods_range_name_1 = "ip-range-pods-simple-autopilot-public-1"
svc_range_name_1 = "ip-range-svc-simple-autopilot-public-1"
subnet_names_2 = [for subnet_self_link in module.gcp-network.subnets_self_links : split("/", subnet_self_link)[length(split("/", subnet_self_link)) - 1]]
}
 
/* data "google_client_config" "default-1" {}
 
provider "kubernetes" {
host = "https://${module.gke.endpoint}"
token = data.google_client_config.default.access_token
cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}
 */
module "gke-1" {
source = "../modules/beta-autopilot-public-cluster/"
project_id = "rmk-demo-344812"
name = "${local.cluster_type}-staging-cluster"
regional = true
region = "europe-west1"
network = module.gcp-network.network_name
subnetwork = local.subnet_names_2[index(module.gcp-network.subnets_names, local.subnet_name)]
ip_range_pods = local.stg-pods_range_name
ip_range_services = local.stg-svc_range_name
release_channel = "REGULAR"
enable_vertical_pod_autoscaling = true
}