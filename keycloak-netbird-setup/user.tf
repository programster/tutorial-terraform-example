# Step 3 in Key
# https://docs.netbird.io/selfhosted/identity-providers#step-3-create-a-user
resource "keycloak_user" "netbird_admin_user" {
    realm_id = keycloak_realm.realm.id
    username  =  var.netbird_admin_email
    email      = var.netbird_admin_email
    first_name = "Netbird"
    last_name  = "Administrator"
    enabled = true

    initial_password {
        value     = var.netbird_admin_password
        temporary = false
    }
}
