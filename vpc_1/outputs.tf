########## VPC Network Block ##########
output "vpc_id" {
    description = "vpc id"
    value = scp_vpc.main.id
}

output "vpc_name" {
    description = "vpc name"
    value = scp_vpc.main.name
}

output "vpc_region" {
    description = "vpc region"
    value = scp_vpc.main.region
}

output "igw_id" {
    description = "internet gateway id "
    value = try(scp_internet_gateway.main[0].id,"")
}

output "subnets-id" {
    description = "subnets id map"
    value = { for k, v in scp_subnet.main: k => v.id }
}

output "ngws_id" {
    description = "nat gateway id map"
    value = { for k, v in scp_nat_gateway.main: k => v.id }
}

output "pips-id" {
    description = "public ip id"
    value = { for k, v in scp_public_ip.main: k => v.id }
}

