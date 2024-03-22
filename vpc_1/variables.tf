variable "project" {
    description = <<-EOF
        description: Project name or service name
        type: string
        required: yes
    EOF
    type = string
}

variable "stage" {
    description = <<-EOF
        description: Service stage of project
        type: string
        required: no
        example:'''
            stage = "dev" # stg, prd
        '''
    EOF
    type = string
}

variable "region_code" {
    description = <<-EOF
        description: Country code for region
        type: string
        required: no
        default: kr
        example:'''
            region_code = "kr"
        '''
    EOF
    type = string
    default = "kr"
}

variable "region" {
    description = <<-EOF
        description: Region name 
        type: string
        required: no
        default: KR-WEST-1
        example:'''
           region = "KR-WEST-1"
        '''
    EOF
    type    = string
    default = "KR-WEST-1"
}

variable "name" {
    description = <<-EOF
        description: vpc name 
        type: string
        required: yes
        input_validate_rule: ^[a-zA-Z0-9]{3,17}$
        input_validate_mesg: Please enter VPC name of 3 to 17 characters, excluding special characters
    EOF
    type    = string
}

variable "subnets" {
    description = <<-EOF
        description: Subnet configuration (subnet name must not be same with subnet type)
        type: any
        required: yes
        example:'''
            # For 3-tier muli-az network,
            subnets         = {
                publicSubnet01  = {cidr = "10.0.1.0/24", type = "public"},
                privnatSubnet01 = {cidr = "10.0.2.0/24", type = "privnat"},
                privnatSubnet02 = {cidr = "10.0.3.0/24", type = "privnat"},
                privateSubnet01 = {cidr = "10.0.4.0/24", type = "private"},
                privateSubnet02 = {cidr = "10.0.5.0/24", type = "private"},
            }
            # For 2-Tier single-az simple network,
            subnets         = {
                publicSubnet01  = {cidr = "10.0.1.0/24", type = "public"},
                privnatSubnet01 = {cidr = "10.0.2.0/24", type = "privnat"},
            }
            # For local network,
            subnets         = {
                vmLocalSubnet01 = {cidr = "192.168.1.0/24", type = "vm"},
                bmLocalSubnet01 = {cidr = "192.168.2.0/24", type = "bm"},
            }
            '''           
    EOF
    type = any

    validation {
        condition = length([for k, v in var.subnets: k if k == v.type]) == 0
        error_message = "subnet name and type must be different"
    }
}

variable "enable_flowlog" {
    description = <<-EOF
        description: Enable network flowlog
        type: bool
        required: no
        default: false
        example:'''
           enable_flowlog = false
        '''
    EOF
    type = bool
    default = false
}

variable "enable_igw" {
    description = <<-EOF
        description: Enable internet gateway
        type: bool
        required: no
        default: false
        example:'''
           enable_igw = true
        '''
    EOF
    type = bool
    default = false
}

variable "igw_type" {
    description = <<-EOF
        description: Internet-Gateway Type. One of SHARED, DEDICATED, SHARED_GROUP
        type: string
        required: no
        example:'''
           igw_type = "SHARED"
        '''
    EOF
    type = string
    default = "SHARED"
}

variable "pips" {
    description = <<-EOF
        description: Public IP Name
        type: list(string)
        required: no
        default: []
        example:'''
           pips = ["bastion01","web01","was01"]
        '''
    EOF
    type = list(string)
    default = []
}

variable "uplink_type" {
    description = <<-EOF
        description: Public IP uplinkType ('INTERNET'|'DEDICATED_INTERNET'|'SHARED_GROUP')
        type: string
        required: no
        example:'''
           uplink_type = "INTERNET"
        '''
    EOF
    type = string
    default = "INTERNET"
}

variable "description" {
    description = <<-EOF
        description: description for VPC
        type: string
        required: no
    EOF
    type        = string
    default     = ""
}

variable "tags" {
    description = <<-EOF
        description: Tags
        type: map(string)
        required: no
        example:'''
            tags = {"createdBy" = "gitops"}
        '''
    EOF
    type = map(string)
    default = {}
}

variable "log_storages" {
    description = <<-EOF
        description: Set up log storages
        type: map(object)
        required: no
        example:'''
        log_storages = {
          "sg" = {
            obs_bucket_id = "S3_OBS_BUCKET-******"
            obs_enable    = true
          },
          "fw" = {
            obs_bucket_id = "S3_OBS_BUCKET-******"
            obs_enable    = true
          },
        }
        '''
    EOF
    type = map(object({
      obs_bucket_id = string
      obs_enable = bool
    }))
    default = {}
}
