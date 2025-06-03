terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 1.10.5"
}

provider "twc" {
  token = var.PROVIDER_TOKEN
}

# Project is created and managed manually.
# Select existing project with name "Conserj"
data "twc_projects" "conserj_project" {
  name = "Conserj"
}

data "twc_os" "os" {
  name    = var.OS_NAME
  version = var.OS_VERSION
}

# TODO: Different configurations for prod and dev (conduct SYSTEM DESIGN later)
# Choose among prespecified configurations that fit provided parameters
data "twc_presets" "preset" {
  location = "ru-1"
  disk        = 1024 * 50
  cpu         = 2
  ram         = 1024 * 4
  preset_type = "premium"

  price_filter {
    from = 300
    to   = 1500
  }
}

# ----- SSH Keys ----->

resource "twc_ssh_key" "maks_key" {
  name = "Maks"
  body = file("~/.ssh/serj_ed25519.pub")
}
resource "twc_ssh_key" "sergei_key" {
  name = "Sergei"
  body = file("~/.ssh/sergei_serj_rsa.pub")
}
# -------------------->

# ----- Development server ----->

resource "twc_server" "dev_server" {
  name    = "SerjDev"
  comment = "Development server for Conserj project."
  os_id   = data.twc_os.os.id
  preset_id = data.twc_presets.preset.id
  project_id = data.twc_projects.conserj_project.id
  ssh_keys_ids = [
    twc_ssh_key.maks_key.id,
    twc_ssh_key.sergei_key.id,
  ]
}

# Is not created by default
resource "twc_server_ip" "dev_ipv4" {
  source_server_id = twc_server.dev_server.id
  type = "ipv4"
}

data "twc_dns_zone" "dns_zone_dev" {
  name = var.DEV_DOMAIN
}
# ------------------------------>
