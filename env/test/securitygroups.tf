##################################################################################
# Security Group Creation                                                        #
##################################################################################
locals {
  message = {
    rdp_from_internal_nw               = "RDP access from HMH internal network"
    ssh_from_admin                     = "SSH access from Admin jump servers"
    rdp_from_admin                     = "RDP access from Admin jump servers"
    https_from_admin                   = "HTTPS access from Admin jump servers"
    https_from_internal_nw             = "HTTPS access from HMH internal network"
    sap_access_from_admin              = "SAP application specific port access from Admin jump servers"
    sap_access_from_internal_nw        = "SAP application specific port access from HMH internal network"
    sap_router_access_from_sap_support = "SAP Router access from SAP Support"
    pvt_app_subnet                     = "Private App subnet access"
    app_access_from_saprouter          = "SAP application specific port access from SAP router"
  }
  ecc_sg_rules = [
    { proto : "tcp", from_port : 22, to_port : 22, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.ssh_from_admin },
    { proto : "tcp", from_port : 443, to_port : 443, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.https_from_admin },
    { proto : "tcp", from_port : 443, to_port : 443, cidr : local.internal_cidr, security_groups : "", desc : local.message.https_from_internal_nw },
    { proto : "tcp", from_port : 1521, to_port : 1521, cidr : local.pvt_app_subnet_supernet_cidr, security_groups : "", desc : local.message.pvt_app_subnet },
    { proto : "tcp", from_port : 8000, to_port : 8000, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 8000, to_port : 8000, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 8000, to_port : 8000, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 8100, to_port : 8100, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 8100, to_port : 8100, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 8100, to_port : 8100, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 1128, to_port : 1130, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 4237, to_port : 4239, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3200, to_port : 3200, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3200, to_port : 3200, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 3200, to_port : 3200, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 3300, to_port : 3300, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3300, to_port : 3300, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 3300, to_port : 3300, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 3600, to_port : 3600, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3600, to_port : 3600, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 3600, to_port : 3600, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 44300, to_port : 44300, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 44300, to_port : 44300, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 44300, to_port : 44300, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 50013, to_port : 50014, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin }
  ]

  bw_sg_rules = [
    { proto : "tcp", from_port : 22, to_port : 22, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.ssh_from_admin },
    { proto : "tcp", from_port : 443, to_port : 443, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.https_from_admin },
    { proto : "tcp", from_port : 443, to_port : 443, cidr : local.internal_cidr, security_groups : "", desc : local.message.https_from_internal_nw },
    { proto : "tcp", from_port : 1521, to_port : 1521, cidr : local.pvt_app_subnet_supernet_cidr, security_groups : "", desc : local.message.pvt_app_subnet },

    { proto : "tcp", from_port : 8000, to_port : 8000, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 8000, to_port : 8000, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 8000, to_port : 8000, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 8100, to_port : 8100, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 8100, to_port : 8100, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 8100, to_port : 8100, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 1128, to_port : 1130, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 4237, to_port : 4239, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3200, to_port : 3200, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3200, to_port : 3200, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 3200, to_port : 3200, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 3300, to_port : 3300, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3300, to_port : 3300, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 3300, to_port : 3300, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 3600, to_port : 3600, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3600, to_port : 3600, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 3600, to_port : 3600, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 44300, to_port : 44300, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 44300, to_port : 44300, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 44300, to_port : 44300, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 50013, to_port : 50014, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin }
  ]
  fiori_sg_rules = [
    { proto : "tcp", from_port : 22, to_port : 22, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.ssh_from_admin },
    { proto : "tcp", from_port : 443, to_port : 443, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.https_from_admin },
    { proto : "tcp", from_port : 443, to_port : 443, cidr : local.internal_cidr, security_groups : "", desc : local.message.https_from_internal_nw },
    { proto : "tcp", from_port : 8000, to_port : 8000, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 8000, to_port : 8000, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 8000, to_port : 8000, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 8100, to_port : 8100, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 8100, to_port : 8100, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 8100, to_port : 8100, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 1128, to_port : 1130, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 4237, to_port : 4239, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3200, to_port : 3200, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3200, to_port : 3200, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 3200, to_port : 3200, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 3300, to_port : 3300, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3300, to_port : 3300, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 3300, to_port : 3300, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 3600, to_port : 3600, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3600, to_port : 3600, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 3600, to_port : 3600, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 44300, to_port : 44300, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 44300, to_port : 44300, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 44300, to_port : 44300, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 50013, to_port : 50014, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin }
  ]
  contentserver_sg_rules = [
    { proto : "tcp", from_port : 3389, to_port : 3389, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.rdp_from_admin },
    { proto : "tcp", from_port : 1080, to_port : 1080, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 1080, to_port : 1080, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin }
  ]
  sabrix_sg_rules = [
    { proto : "tcp", from_port : 22, to_port : 22, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.ssh_from_admin },
    { proto : "tcp", from_port : 8080, to_port : 8080, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 8080, to_port : 8080, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw }
  ]
  paymetrics_sg_rules = [
    { proto : "tcp", from_port : 3389, to_port : 3389, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.rdp_from_admin }
  ]
  saprouter_sg_rules = [
    { proto : "tcp", from_port : 22, to_port : 22, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.ssh_from_admin },
    { proto : "tcp", from_port : 3299, to_port : 3299, cidr : local.sap_support_ip, security_groups : "", desc : local.message.sap_router_access_from_sap_support }
  ]
  scm_sg_rules = [
    { proto : "tcp", from_port : 22, to_port : 22, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.ssh_from_admin },
    { proto : "tcp", from_port : 443, to_port : 443, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.https_from_admin },
    { proto : "tcp", from_port : 443, to_port : 443, cidr : local.internal_cidr, security_groups : "", desc : local.message.https_from_internal_nw },
    { proto : "tcp", from_port : 7200, to_port : 7200, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 8000, to_port : 8000, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 8000, to_port : 8000, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 8000, to_port : 8000, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 8100, to_port : 8100, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 8100, to_port : 8100, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 8100, to_port : 8100, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 1128, to_port : 1130, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 4237, to_port : 4239, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3200, to_port : 3200, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3200, to_port : 3200, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 3200, to_port : 3200, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 3300, to_port : 3300, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3300, to_port : 3300, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 3300, to_port : 3300, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 3600, to_port : 3600, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 3600, to_port : 3600, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 3600, to_port : 3600, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 44300, to_port : 44300, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin },
    { proto : "tcp", from_port : 44300, to_port : 44300, cidr : local.internal_cidr, security_groups : "", desc : local.message.sap_access_from_internal_nw },
    { proto : "tcp", from_port : 44300, to_port : 44300, cidr : local.saprouter_supernet_cidr, security_groups : "", desc : local.message.app_access_from_saprouter },
    { proto : "tcp", from_port : 50013, to_port : 50014, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.sap_access_from_admin }
  ]
  bpc_sg_rules = [
    { proto : "tcp", from_port : 22, to_port : 22, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.ssh_from_admin }
  ]
  solman_sg_rules = [
    { proto : "tcp", from_port : 22, to_port : 22, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.ssh_from_admin }
  ]
  winadmin_sg_rules = [
    { proto : "tcp", from_port : 3389, to_port : 3389, cidr : local.internal_cidr, security_groups : "", desc : local.message.rdp_from_internal_nw }
  ]
  oracledb_sg_rules = [
    { proto : "tcp", from_port : 22, to_port : 22, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.ssh_from_admin },
    ### App SGs requiring oracle db access will be added here. Below rules need to be changed appropriately.
    { proto : "tcp", from_port : 1521, to_port : 1521, cidr : "", security_groups : module.ecc_sg.sg_group_id, desc : "" },
    { proto : "tcp", from_port : 1521, to_port : 1521, cidr : "", security_groups : module.bw_sg.sg_group_id, desc : "" }
  ]
  mssqldb_sg_rules = [
    { proto : "tcp", from_port : 3389, to_port : 3389, cidr : "", security_groups : module.winadmin_sg.sg_group_id, desc : local.message.rdp_from_admin },
    ### App SGs requiring oracle db access will be added here. Below rules need to be changed appropriately.
    { proto : "tcp", from_port : 1433, to_port : 1433, cidr : "", security_groups : module.ecc_sg.sg_group_id, desc : "" },
  ]
  core_sg_rules = [
    { proto : "tcp", from_port : 88, to_port : 88, cidr : local.dns_cidr, security_groups : "", desc : "Kerberos TCP port access" },
    { proto : "udp", from_port : 123, to_port : 123, cidr : local.dns_cidr, security_groups : "", desc : "NTP UDP port access" },
    { proto : "tcp", from_port : 135, to_port : 135, cidr : local.dns_cidr, security_groups : "", desc : "RPC TCP port access" },
    { proto : "tcp", from_port : 139, to_port : 139, cidr : local.dns_cidr, security_groups : "", desc : "NetBIOS Session Service TCP port access" },
    { proto : "tcp", from_port : 389, to_port : 389, cidr : local.dns_cidr, security_groups : "", desc : "LDAP TCP port" },
    { proto : "udp", from_port : 389, to_port : 389, cidr : local.dns_cidr, security_groups : "", desc : "LDAP UDP port" },
    { proto : "tcp", from_port : 445, to_port : 445, cidr : local.dns_cidr, security_groups : "", desc : "SMB TCP port" },
    { proto : "tcp", from_port : 464, to_port : 464, cidr : local.dns_cidr, security_groups : "", desc : "Kerberos password change TCP port" },
    { proto : "tcp", from_port : 636, to_port : 636, cidr : local.dns_cidr, security_groups : "", desc : "LDAP SSL TCP port" },
    { proto : "udp", from_port : 636, to_port : 636, cidr : local.dns_cidr, security_groups : "", desc : "LDAP SSL UDP port" },
    { proto : "tcp", from_port : 53, to_port : 53, cidr : local.dns_cidr, security_groups : "", desc : "DNS TCP port" },
    { proto : "udp", from_port : 53, to_port : 53, cidr : local.dns_cidr, security_groups : "", desc : "DNS UDP port" },
    { proto : "tcp", from_port : 3268, to_port : 3269, cidr : local.dns_cidr, security_groups : "", desc : "Global Catalog TCP port access" },
    { proto : "tcp", from_port : 49152, to_port : 65535, cidr : local.dns_cidr, security_groups : "", desc : "Randomly allocated high TCP ports access" }
  ]
  s3_interfacegw_sg_rules = [
    { proto : "tcp", from_port : 443, to_port : 443, cidr : "10.10.60.0/24", security_groups : "", desc : "S3 interface gateway access" }
  ]
}
## Core infra related security groups
module "winadmin_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "Windows Admin Security Group"
  sg_name        = "${local.resource_prefix}-winadmin-sg"
  sg_rules       = local.winadmin_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-winadmin-sg"), var.env_tags)
}
module "s3_interfacegw_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "S3 Interface GW Security Group"
  sg_name        = "${local.resource_prefix}-s3_interfacegw-sg"
  sg_rules       = local.s3_interfacegw_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-s3_interfacegw-sg"), var.env_tags)
}
module "core_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "Core Security Group"
  sg_name        = "${local.resource_prefix}-core-sg"
  sg_rules       = local.core_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-core-sg"), var.env_tags)
}
## DB related security groups
module "oracledb_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "Oracle DB Servers Security Group"
  sg_name        = "${local.resource_prefix}-oracledb-sg"
  sg_rules       = local.oracledb_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-oracledb-sg"), var.env_tags)
}
module "mssqldb_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "MS SQLServer DB Servers Security Group"
  sg_name        = "${local.resource_prefix}-mssqldb-sg"
  sg_rules       = local.mssqldb_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-mssqldb-sg"), var.env_tags)
}

# SAP/App specific groups
module "bw_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "BW Servers Security Group"
  sg_name        = "${local.resource_prefix}-bw-sg"
  sg_rules       = local.bw_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-bw-sg"), var.env_tags)
}

module "ecc_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "ECC Servers Security Group"
  sg_name        = "${local.resource_prefix}-ecc-sg"
  sg_rules       = local.ecc_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-ecc-sg"), var.env_tags)
}

module "fiori_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "Fiori Servers Security Group"
  sg_name        = "${local.resource_prefix}-fiori-sg"
  sg_rules       = local.fiori_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-fiori-sg"), var.env_tags)
}

module "contentserver_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "ContentServer Servers Security Group"
  sg_name        = "${local.resource_prefix}-contentserver-sg"
  sg_rules       = local.contentserver_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-contentserver-sg"), var.env_tags)
}

module "sabrix_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "Sabrix Servers Security Group"
  sg_name        = "${local.resource_prefix}-sabrix-sg"
  sg_rules       = local.sabrix_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-sabrix-sg"), var.env_tags)
}

module "paymetrics_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "Paymetrics Servers Security Group"
  sg_name        = "${local.resource_prefix}-paymetrics-sg"
  sg_rules       = local.paymetrics_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-paymetrics-sg"), var.env_tags)
}

module "saprouter_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "SAP Router Servers Security Group"
  sg_name        = "${local.resource_prefix}-saprouter-sg"
  sg_rules       = local.saprouter_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-saprouter-sg"), var.env_tags)
}

module "scm_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "SCM Servers Security Group"
  sg_name        = "${local.resource_prefix}-scm-sg"
  sg_rules       = local.scm_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-scm-sg"), var.env_tags)
}

module "bpc_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "BPC Servers Security Group"
  sg_name        = "${local.resource_prefix}-bpc-sg"
  sg_rules       = local.bpc_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-bpc-sg"), var.env_tags)
}

module "solman_sg" {
  source         = "../../modules/networking/sg/sg_group"
  vpc_id         = local.vpc_id
  sg_description = "SolMan Servers Security Group"
  sg_name        = "${local.resource_prefix}-solman-sg"
  sg_rules       = local.solman_sg_rules
  env_tags       = merge(map("Name", "${local.resource_prefix}-solman-sg"), var.env_tags)
}
