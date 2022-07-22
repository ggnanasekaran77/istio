locals {

#                                  _
#                                 | |
#   __ _  ___ _ __   ___ _ __ __ _| |
#  / _` |/ _ \ '_ \ / _ \ '__/ _` | |
# | (_| |  __/ | | |  __/ | | (_| | |
#  \__, |\___|_| |_|\___|_|  \__,_|_|
#   __/ |
#  |___/
#

# Prefix is used in resource names to quickly identify that resource is created
# using Terraform
prefix = "safi"

# This message is used in descriptions, if possible, to let know that resouce
# is managed Terraform. Any manual change of the resource should be avoided
managed_by_terraform = "Managed by Terraform. DO NOT edit manually!"

# List of environments and status of features within the environment. Feature
# toogles can help to deploy new environment in more gradual way to limit risk
# of having too many failed Terraform runs
safi_environments = {
  dev = {
    domain_name = "smallog.tech"
    features = {
      example_feature = true
    }
  }

  # stage = {
  #   domain_name = "blueship.store"
  #   features = {
  #     example_feature = false
  #   }
  # }

  # prod = {
  #   domain_name = "safibank.ph"
  #   features = {
  #     example_feature = false
  #   }
  # }
}

# Github organization
github_owner = "SafiBank"

#  _   _ ___  ___ _ __ ___
# | | | / __|/ _ \ '__/ __|
# | |_| \__ \  __/ |  \__ \
#  \__,_|___/\___|_|  |___/
#

safi_devops_users = [
  {
    # General
    name  = "Aleksandr Kanaev"
    email = "aleksandr.kanaev@vacuumlabs.com"
    gcp_email = "aleksandr.kanaev@vacuumlabs.com"

    # Terraform
    terraform_cloud = {
      teams = [
        "cicd",
        "repos",
        "env-dev",
        "dns-safibank-online",
      ]
    }

    # Google Cloud Platform
    gcp = {
      projects_iam = [
        {
          project = "safi-cicd"
          roles   = [
            "roles/editor",
          ]
        },
        {
          project = "safi-env-dev-apps"
          roles   = [
            "roles/viewer",
          ]
        }
      ]
    }
  },

  {
    # General
    name  = "Bharath Dasaraju"
    email = "bharath.dasaraju@advancegroup.com"
    gcp_email = "bhrth.dsra1@gmail.com"

    # Terraform
    terraform_cloud = {
      teams = [
        "dispatcher",
        "env-dev"
      ]
    }

    # Google Cloud Platform
    gcp = {
      projects_iam = [
        {
          project = "safi-env-dev-tyk"
          roles   = [
            "roles/editor",
          ]
        }
      ]
    }
  },

  {
    # General
    name  = "Gnanasekaran Gajendi"
    email = "gnanasekaran.gajendi@advancegroup.com"
    gcp_email = "ggnanasekaran77@gmail.com"

    # Terraform
    terraform_cloud = {
      teams = []
    }

    # Google Cloud Platform
    gcp = {
      projects_iam = [
        {
          project = "safi-env-dev-tyk"
          roles   = [
            "roles/viewer",
          ]
        }
      ]
    }
  },

  {
    # General
    name  = "Justin Lacsina"
    email = "fol.lacsina@advancegroup.com"
    gcp_email = "efowel2@gmail.com"

    # Terraform
    terraform_cloud = {
      teams = []
    }

    # Google Cloud Platform
    gcp = {
      projects_iam = [
        {
          project = "safi-env-dev-apps"
          roles   = [
            "roles/viewer",
          ]
        }
      ]
    }
  },

  {
    # General
    name  = "Lucky La Torre"
    email = "lucky.latorre@advancegroup.com"
    gcp_email = "luckyguylatorre@gmail.com"

    # Terraform
    terraform_cloud = {
      teams = ["env-dev"]
    }

    # Google Cloud Platform
    gcp = {
      projects_iam = [
        {
          project = "safi-env-dev-apps"
          roles   = [
            "roles/viewer",
          ]
        },
        {
          project = "safi-env-dev-monitoring"
          roles   = [
            "roles/editor",
            "roles/container.admin"
          ]
        },
        {
          project = "safi-env-dev-hcv"
          roles   = [
            "roles/viewer",
          ]
        }
      ]
    }
  },

  {
    # General
    name  = "Pavol antalik"
    email = "pavol.antalik@vacuumlabs.com"
    gcp_email = "pavol.antalik@vacuumlabs.com"

    # Terraform
    terraform_cloud = {
      teams = [
        "env-dev"
      ]
    }

    # Google Cloud Platform
    gcp = {
      projects_iam = [
        {
          project = "safi-env-dev-tm"
          roles   = [
            "roles/viewer",
          ]
        }
      ]
    }
  },

  {
    # General
    name  = "Peter Kmec"
    email = "peter.kmec@vacuumlabs.com"
    gcp_email = "peter.kmec@vacuumlabs.com"

    # Terraform
    terraform_cloud = {
      teams = [
        "dispatcher",
        "dns-safibank-online",
        "env-dev"
      ]
    }

    # Google Cloud Platform
    gcp = {
      projects_iam = [
        {
          project = "safi-env-dev-apps"
          roles   = [
            "roles/editor",
          ]
        }
      ]
    }
  },

  {
    # General
    name  = "Veneraldo Apelo"
    email = "veneraldo.apelo@advancegroup.com"
    gcp_email = "veneraldo@gmail.com"

    # Terraform
    terraform_cloud = {
      teams = []
    }

    # Google Cloud Platform
    gcp = {
      projects_iam = [
        {
          project = "safi-env-dev-apps"
          roles   = [
            "roles/viewer",
          ]
        }
      ]
    }
  },
]

#             _                      _
#            | |                    | |
#  _ __   ___| |___      _____  _ __| | __
# | '_ \ / _ \ __\ \ /\ / / _ \| '__| |/ /
# | | | |  __/ |_ \ V  V / (_) | |  |   <
# |_| |_|\___|\__| \_/\_/ \___/|_|  |_|\_\
#

safi_network = {
  cicd = {
    gcp_services = "10.30.128.0/18"
    k8s = {
      master = "192.168.3.0/28"
      nodes  = "172.19.0.0/20"
      svc    = "10.30.0.0/18"
      pods   = "10.30.64.0/18"
    }
  }

  env = {
    dev = {
      gcp_services = "10.0.0.0/18"
      projects = {
        tm = {

          k8s = {
            master   = "192.168.0.0/28"
            nodes    = "172.16.0.0/20"
            svc      = "10.0.128.0/18"
            pods     = "10.0.64.0/18"
          }

          private-default = {
            master   = "192.168.0.16/28"
            nodes    = "172.16.16.0/20"
            svc      = "10.1.0.0/18"
            pods     = "10.0.192.0/18"
          }

        }

        apps = {

          k8s = {
            master   = "192.168.0.32/28"
            nodes    = "172.16.32.0/20"
            svc      = "10.1.128.0/18"
            pods     = "10.1.64.0/18"
          }

          private-default = {
            master   = "192.168.0.48/28"
            nodes    = "172.16.48.0/20"
            svc      = "10.2.0.0/18"
            pods     = "10.1.192.0/18"
          }

        }
      tyk = {

            k8s = {
              master = "192.168.0.96/28"
              nodes  = "172.16.96.0/20"
              svc    = "10.3.128.0/18"
              pods   = "10.3.64.0/18"
            }

           }
            #hcv = {}
          #monitoring = {}
        }
      }
      #staging = {}
      #prod = {}
    }
  }

#                    _ _           _   _
#                   | (_)         | | (_)
#   __ _ _ __  _ __ | |_  ___ __ _| |_ _  ___  _ __  ___
#  / _` | '_ \| '_ \| | |/ __/ _` | __| |/ _ \| '_ \/ __|
# | (_| | |_) | |_) | | | (_| (_| | |_| | (_) | | | \__ \
#  \__,_| .__/| .__/|_|_|\___\__,_|\__|_|\___/|_| |_|___/
#       | |   | |
#       |_|   |_|

  safi_microservices = {
    # -----------------------------
    advanceai_gateway = {
      create_postgres = false
      inject_secrets = []
    }

    # -----------------------------
    card_manager = {
      create_postgres = true
      inject_secrets = [
        "kafka",
      ]
    }

    # -----------------------------
    customer_manager = {
      create_postgres = true
      inject_secrets = [
        "kafka",
        "temporal"
      ]
    }

    # -----------------------------
    loan_manager = {
      create_postgres = true
      inject_secrets = [
        "kafka",
        "temporal"
      ]
    }

    # -----------------------------
    transaction_history_manager = {
      create_postgres = true
      inject_secrets = [
        "kafka",
        "temporal"
      ]
    }

    # -----------------------------
    transaction_processor_manager = {
      create_postgres = true
      inject_secrets = [
        "kafka",
        "temporal"
      ]
    }

    # -----------------------------
    account_manager = {
      create_postgres = true
      inject_secrets = [
        "kafka",
        "temporal"
      ]
    }

    # -----------------------------
    product_manager = {
      create_postgres = true
      inject_secrets = [
        "kafka",
        "temporal"
      ]
    }

     # -----------------------------
    output_manager = {
      create_postgres = false
      inject_secrets = [
        "kafka"
      ]
    }
  }
}
