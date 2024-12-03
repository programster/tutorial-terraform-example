# Creates client scope (Step 6: https://bit.ly/3ZDj8cl) that can be attached to clients that use the OpenID Connect
#  protocol
#  https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/openid_client_scope
resource "keycloak_openid_client_scope" "openid_client_scope" {
    realm_id               = keycloak_realm.realm.id
    name                   = "api"
    description            = ""
    include_in_token_scope = true
    gui_order              = 1
}


# Create an audience (step 7: https://bit.ly/4ihoHV2) that maps to the API scope created in step 6.
# Creates an audience protocol mapper to allow adding audiences to the aud claim within issued tokens.
# The audience can be a custom string, or it can be mapped to the ID of a pre-existing client.
# The audience is presented as the aud claim in the access token. It's typically the resource server (API) that a
# client (application) would like to access.
# https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/openid_audience_protocol_mapper
resource "keycloak_openid_audience_protocol_mapper" "audience_mapper" {
    realm_id        = keycloak_realm.realm.id
    client_scope_id = keycloak_openid_client_scope.openid_client_scope.id
    name            = "Audience for NetBird Management API"
    included_client_audience = keycloak_openid_client.netbird_application_client.client_id

    # Indicates if the audience should be included in the aud claim for the id token.
    add_to_access_token = true
}


# Default the API scope to the netbird client.
resource "keycloak_openid_client_default_scopes" "client_default_scopes" {
    realm_id  = keycloak_realm.realm.id
    client_id = keycloak_openid_client.netbird_application_client.id

    default_scopes = [
        keycloak_openid_client_scope.openid_client_scope.name,
    ]
}

