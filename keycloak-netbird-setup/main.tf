terraform {
    required_providers {
        keycloak = {
            source = "mrparkers/keycloak"
            version = "4.4.0"
        }
    }
}


provider "keycloak" {
    client_id     = "admin-cli"
    username      = var.keycloak_auth_username
    password      = var.keycloak_auth_password
    url           = var.keycloak_url
}


