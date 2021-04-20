##################################################################################
# PROVIDERS                                                                      #
##################################################################################
provider "aws" {
  profile = "default"
  #region  = "us-east-1"
}

terraform {
  required_version = ">= 0.13.4"
}

locals {
  #Dummy IPs
  vpc_id          = "vpc-0000000000"
  vpc_cidr        = "10.110.116.0/22"
  vpgw_id         = "vgw-0000000000"
  default_rtb_id  = "rtb-0000000000"
  environment     = "qa"
  resource_prefix = "custname-erp-qa"
  all_ips         = "0.0.0.0/0"
  sap_support_ip  = "194.39.131.34/32"
  internal_cidr   = "10.90.0.0/12"
  dns_cidr        = "10.196.10.36/31"
  paymetrics_saas_cidr         = "10.120.110.0/23"
  pvt_app_subnet_supernet_cidr = "10.110.120.128/25"
  saprouter_supernet_cidr      = "10.140.130.0/25"
  admin_supernet               = "10.150.140.0/25"
  admin_subnets = {
    #default = {
    #Splitting 10.110.118.0/25 with 62 IPs each
    0 = {
      cidr    = "10.110.118.0/26",
      az      = "us-east-1a",
      az_name = "az1"
    },
    1 = {
      cidr    = "10.110.118.64/26",
      az      = "us-east-1b",
      az_name = "az2"
    }
    #  }
  }
  app_subnets = {
    0 = {
      cidr    = "10.110.118.128/26",
      az      = "us-east-1a",
      az_name = "az1"
    },
    1 = {
      cidr    = "10.110.118.192/26",
      az      = "us-east-1b",
      az_name = "az2"
    }
  }
  saprouter_subnets = {
    0 = {
      cidr    = "10.110.116.0/26",
      az      = "us-east-1a",
      az_name = "az1"
    },
    1 = {
      cidr    = "10.110.116.64/26",
      az      = "us-east-1b",
      az_name = "az2"
    }
  }
  public_subnets = {
    0 = {
      cidr    = "10.110.117.0/26",
      az      = "us-east-1a",
      az_name = "az1"
    },
    1 = {
      cidr    = "10.110.117.64/26",
      az      = "us-east-1b",
      az_name = "az2"
    }
  }
  db_subnets = {
    0 = {
      cidr    = "10.110.119.0/26",
      az      = "us-east-1a",
      az_name = "az1"
    },
    1 = {
      cidr    = "10.110.119.64/26",
      az      = "us-east-1b",
      az_name = "az2"
    }
  }
}

data "aws_region" "current" {}
