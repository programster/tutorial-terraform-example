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

// Need to replace this with a solution from https://stackoverflow.com/questions/79207185/use-terraform-to-assign-realm-management-role-to-service-account-user-in-keycloa
// when it becomes available.
resource "keycloak_role" "view_users_role" {
    realm_id = keycloak_realm.realm.id
    name     = "view-users"
}

resource "keycloak_openid_client_service_account_realm_role" "service_account_role_assignment" {
    realm_id                = keycloak_realm.realm.id
    service_account_user_id = keycloak_openid_client.netbird_backend_client.service_account_user_id
    role                    = keycloak_role.view_users_role.name
}


