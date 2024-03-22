########## Local Block ##########
locals {
  tag_suffix = "${var.project}_${var.stage}_${var.region_code}"
}
########## Local Block ##########

########## VPC Network Block ##########
resource "scp_vpc" "main" {
  name        = var.name
  region      = var.region
  description = var.description
  tags        = var.tags
}

resource "scp_internet_gateway" "main" {
  count       = var.enable_igw? 1 : 0
  vpc_id      = scp_vpc.main.id
  igw_type    = var.igw_type
  description = var.description
  depends_on  = [scp_vpc.main]
  tags        = var.tags
}

resource "scp_subnet" "main" {
  for_each    = var.subnets
  vpc_id      = scp_vpc.main.id
  name        = each.key
  cidr_ipv4   = each.value.cidr
  type        = each.value.type == "privnat" ? "PRIVATE" : upper(each.value.type)
  description = var.description
  tags        = var.tags
  depends_on  = [scp_vpc.main, scp_internet_gateway.main]
}

resource "scp_nat_gateway" "main" {
  for_each = toset([ for k, v in var.subnets: k if v.type == "privnat" ])
  subnet_id    = scp_subnet.main[each.key].id
  description = var.description
  tags        = var.tags
  depends_on  = [scp_subnet.main, scp_public_ip.main, scp_internet_gateway.main]
}

resource "scp_public_ip" "main" {
  for_each    = toset(var.pips)
  region      = var.region
  uplink_type = var.uplink_type
  description = var.description
  tags        = { "name" = each.value }
  depends_on  = [scp_vpc.main, scp_internet_gateway.main]
}

########## VPC Log Mgmt Block ##########
resource "scp_security_group_logstorage" "sg_storage" {
  for_each = { for k, log_storage in var.log_storages : k => log_storage if k == "sg" && log_storage.obs_enable }

  vpc_id        = scp_vpc.main.id
  obs_bucket_id = each.value.obs_bucket_id
}

resource "scp_firewall_logstorage" "fw_storage" {
  for_each = { for k, log_storage in var.log_storages : k => log_storage if k == "fw" && log_storage.obs_enable }

  vpc_id        = scp_vpc.main.id
  obs_bucket_id = each.value.obs_bucket_id
}

