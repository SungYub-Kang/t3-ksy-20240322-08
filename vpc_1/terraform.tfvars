project         = "gitops"
stage           = "dev"
region_code     = "kr"
region          = "KR-WEST-1"
name            = "changeme"
subnets         = {
        publicSubnet01  = {cidr = "10.0.1.0/24", type = "public"},
        privnatSubnet01 = {cidr = "10.0.2.0/24", type = "privnat"},
        privnatSubnet02 = {cidr = "10.0.3.0/24", type = "privnat"},
        privateSubnet01 = {cidr = "10.0.4.0/24", type = "private"},
        privateSubnet02 = {cidr = "10.0.5.0/24", type = "private"}
}
enable_igw      = true
pips            = []
tags = { 
  "createdBy" = "gitops"
}

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
