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

module "gcp-network" {
  source  = "terraform-google-modules/network/google"
  version = ">= 4.0.1, < 5.0.0"

  project_id   = "rmk-demo"
  network_name = local.network_name

  subnets = [
    {
      subnet_name   = local.subnet_name
      subnet_ip     = "10.0.0.0/17"
      subnet_region = "europe-west1"
    },
    {
      subnet_name   = local.master_auth_subnetwork
      subnet_ip     = "10.60.0.0/17"
      subnet_region = "europe-west1"
    },
  ]

  secondary_ranges = {
    (local.subnet_name) = [
      {
        range_name    = local.prod-pods_range_name
        ip_cidr_range = "10.21.0.0/17"
      },
      {
        range_name    = local.prod-svc_range_name
        ip_cidr_range = "10.21.128.0/22"
      },
      {
        range_name    = local.stg-pods_range_name
        ip_cidr_range = "10.78.0.0/17"
      },
      {
        range_name    = local.stg-svc_range_name
        ip_cidr_range = "10.78.128.0/22"
      },
    ]
  }
}
