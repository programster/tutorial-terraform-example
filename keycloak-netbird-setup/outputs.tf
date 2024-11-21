output "client_id" {
    value = keycloak_openid_client.netbird_application_client.client_id
    sensitive = true
}

output "client_secret" {
    value = keycloak_openid_client.netbird_application_client.client_secret
    sensitive = true
}

output "NETBIRD_IDP_MGMT_CLIENT_SECRET" {
    value = keycloak_openid_client.netbird_backend_client.client_secret
    sensitive = true
}



# output "keycloak_user_id" {
#     value = keycloak_user.netbird_admin_user.id
# }