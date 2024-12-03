# Step 8 - Creating the netbird backend client: https://docs.netbird.io/selfhosted/identity-providers#step-8-create-a-net-bird-backend-client
# this is used later to set the NETBIRD_IDP_MGMT_CLIENT_ID in the netbird setup.
resource "keycloak_openid_client" "netbird_backend_client" {
    realm_id            = keycloak_realm.realm.id
    client_id           = var.netbird_backend_client_id
    name                = var.netbird_backend_client_name
    enabled             = true


    access_type         = "CONFIDENTIAL"

    service_accounts_enabled = true

    standard_flow_enabled = true
    implicit_flow_enabled = false
    direct_access_grants_enabled = true
    oauth2_device_authorization_grant_enabled = true

    root_url = var.netbird_url

    valid_redirect_uris = [
        "${var.netbird_url}/*"
    ]

    valid_post_logout_redirect_uris = [
        "${var.netbird_url}/*"
    ]

    web_origins = [
        "+"
    ]

    login_theme = "keycloak"
}


# load in the existing realm-management client
data "keycloak_openid_client" "realm_management_client" {
    realm_id = keycloak_realm.realm.id
    client_id = "realm-management"
}


# Assign the realm-management view-users role to the netbird backend client's service management
resource "keycloak_openid_client_service_account_role" "service_account_role_assignment" {
    realm_id                = keycloak_realm.realm.id
    service_account_user_id = keycloak_openid_client.netbird_backend_client.service_account_user_id
    client_id               = data.keycloak_openid_client.realm_management_client.id // ID of the client the role belongs to, not ID of client assigning to.
    role                    = "view-users"
}


