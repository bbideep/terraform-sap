variable "env_tags" {
  type = map(any)
  default = {
    "lob"     = "it",
    "product" = "enterprise-resource-planning",
    "stage"   = "qa",
    "shared"  = "false"
    "cost"        = "enterprise-resource-planning",
    "environment" = "qa",
    "Deployment"  = "SAP"
  }
}
variable "service_tags_bpc" {
  type = map(any)
  default = {
    "service" = "business-planning-consolidation"
  }
}
variable "service_tags_bw" {
  type = map(any)
  default = {
    "service" = "business-warehouse"
  }
}
variable "service_tags_contentserver" {
  type = map(any)
  default = {
    "service" = "content-server"
  }
}
variable "service_tags_ecc" {
  type = map(any)
  default = {
    "service" = "erp-central-component"
  }
}
variable "service_tags_fiori" {
  type = map(any)
  default = {
    "service" = "fiori"
  }
}
variable "service_tags_paymetric" {
  type = map(any)
  default = {
    "service" = "paymetric"
  }
}
variable "service_tags_sabrix" {
  type = map(any)
  default = {
    "service" = "sabrix"
  }
}
variable "service_tags_scm" {
  type = map(any)
  default = {
    "service" = "supply-chain-management"
  }
}
variable "service_tags_solman" {
  type = map(any)
  default = {
    "service" = "solution-manager"
  }
}
variable "service_tags_saprouter" {
  type = map(any)
  default = {
    "service" = "sap-router"
  }
}