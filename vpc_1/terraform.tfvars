enable_igw = true
pips = []
project = "gitops"
description = ""
tags = { 
  "createdBy" = "gitops"
}
uplink_type = "INTERNET"
stage = "dev"
enable_flowlog = false
log_storages = {
  "sg" = {
    obs_bucket_id = "changeme"
    obs_enable    = true
  },
  "fw" = {
    obs_bucket_id = "changeme"
    obs_enable    = true
  },
}
name = "ksyvpc2024032208"
subnets = {
        publicSubnet01  = {cidr = "10.0.1.0/24", type = "public"},
        privnatSubnet01 = {cidr = "10.0.2.0/24", type = "privnat"},
        privnatSubnet02 = {cidr = "10.0.3.0/24", type = "privnat"},
        privateSubnet01 = {cidr = "10.0.4.0/24", type = "private"},
        privateSubnet02 = {cidr = "10.0.5.0/24", type = "private"}
}
region = "KR-WEST-1"
region_code = "kr"
igw_type = "SHARED"
