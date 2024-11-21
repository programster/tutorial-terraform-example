# Step 4 - Creating the netbird client: https://docs.netbird.io/selfhosted/identity-providers#step-4-create-a-net-bird-client
resource "keycloak_openid_client" "netbird_application_client" {
    realm_id            = keycloak_realm.realm.id
    client_id           = var.netbird_application_client_id
    name                = var.netbird_application_client_name
    enabled             = true

    access_type         = "PUBLIC" # setting this to "public", is what sets "client authentication" off in web UI.

    standard_flow_enabled = true
    implicit_flow_enabled = false
    direct_access_grants_enabled = true
    service_accounts_enabled = false
    oauth2_device_authorization_grant_enabled = true # the OAuth2 Client Credentials grant will be enabled for this client.

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

