
resource "keycloak_realm" "realm" {
    realm             = var.realm_name_slug
    enabled           = true
    display_name      = var.realm_display_name
    display_name_html = "<b>${var.realm_display_name}</b>"

    login_theme = "base"
    access_code_lifespan = "1h"
    ssl_required    = "external"
    password_policy = "upperCase(1) and length(8) and forceExpiredPasswordChange(365) and notUsername"

    // login settings: https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/realm#login-settings
    registration_allowed = false
    registration_email_as_username = true
    remember_me = true
    reset_password_allowed = true
    edit_username_allowed = false
    verify_email = false
    login_with_email_allowed = true
    duplicate_emails_allowed = false

    smtp_server {
        host = var.smtp_host
        port = var.smtp_port
        from = var.smtp_from_email
        from_display_name = var.smtp_from_display_name
        reply_to = var.smtp_reply_to_email
        reply_to_display_name = var.smtp_reply_to_display_name
        starttls = var.smtp_use_starttls
        ssl = var.smtp_use_ssl

        auth {
            username = var.smtp_username
            password = var.smtp_password
        }
    }

    internationalization {

        // A list of ISO 639-1 locale codes that the realm should support.
        supported_locales = [
            "en",
        ]
        default_locale    = "en"
    }

    security_defenses {
        headers {
            x_frame_options                     = "DENY"
            content_security_policy             = "frame-src 'self'; frame-ancestors 'self'; object-src 'none';"
            content_security_policy_report_only = ""
            x_content_type_options              = "nosniff"
            x_robots_tag                        = "none"
            x_xss_protection                    = "1; mode=block"
            strict_transport_security           = "max-age=31536000; includeSubDomains"
        }
        brute_force_detection {
            permanent_lockout                 = false
            max_login_failures                = 30
            wait_increment_seconds            = 60
            quick_login_check_milli_seconds   = 1000
            minimum_quick_login_wait_seconds  = 60
            max_failure_wait_seconds          = 900
            failure_reset_time_seconds        = 43200
        }
    }
}

