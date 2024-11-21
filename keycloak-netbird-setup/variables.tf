
variable "keycloak_url" {
    type = string
    description = "The location of the Keycloak host. E.g. http://keycloak.mydomain.com:8080/ or https://keycloak.mydomain.com/"
}

variable "keycloak_auth_username" {
    type = string
    description = "The username for Terraform/Tofu to connect to Keycloak with."
    sensitive = true
}

variable "keycloak_auth_password" {
    type = string
    description = "The password for Terraform/Tofu to connect to Keycloak with."
    sensitive = true
}

variable "realm_name_slug" {
    type = string
    description = "The name to give to the realm created for Netbird. This cannot contain spaces, but can use hyphens."
}

variable "realm_display_name" {
    type = string
    description = "The display name to give to the realm created for Netbird. This can contain spaces."
}

variable "smtp_host" {
    type = string
    description = "The host of your SMTP server. E.g. smtp.gmail.com"
}

variable "smtp_port" {
    type = number
    description = "The port to connect to the SMTP server on."
}

variable "smtp_from_email" {
    type = string
    description = "The email address from which emails should come from. E.g. example@example.com"
}

variable "smtp_from_display_name" {
    type = string
    description = "The name the email should appear from. E.g. 'Keycloak Server'"
}

variable "smtp_reply_to_email" {
    type = string
    description = "The email address use use for reply-to. This should probably be noreply@mydomain.com"
}

variable "smtp_reply_to_display_name" {
    type = string
    description = "The name that should appear for the SMTP reply-to address. This should probably be something like Noreply."
}

variable smtp_use_starttls {
    type = bool
    description = "Whether to use STARTTLS for your SMTP connection. This should not be set to true if smtp_use_ssl is set to true."
}

variable smtp_use_ssl {
    type = bool
    description = "Whether to use SSL for your SMTP connection. This should not be set to true if smtp_use_starttls is set to true."
}

variable "smtp_username" {
    type = string
    description = "The username for your SMTP server. This would be your email address if gmail, but not if you are using AWS SES."
    sensitive = true
}

variable "smtp_password" {
    type = string
    description = "The password that corresponds to your username for your SMTP server."
    sensitive = true
}

variable "netbird_url" {
    type = string
    description = "The full URL of your Netbird server. E.g. https://netbird.mydomain.com/"
}

variable "netbird_application_client_id" {
    type = string
    description = "The string ID for the Netbird client."
    default = "netbird-client"
}

variable "netbird_application_client_name" {
    type = string
    description = "The display name for the Netbird client."
    default = "Netbird Application Client"
}

variable "netbird_backend_client_id" {
    type = string
    description = "The string ID for the Netbird backend client."
    default = "netbird-backend-client"
}

variable "netbird_backend_client_name" {
    type = string
    description = "The display name for the Netbird backend client."
    default = "Netbird Backend Client"
}


variable "netbird_admin_email" {
    type = string
    description = "The email address of the user that will be the administrator in Keycloak for Netbird."
}

variable "netbird_admin_password" {
    type = string
    description = "The password for the administrator created in Keycloak for Netbird"
    sensitive = true
}

