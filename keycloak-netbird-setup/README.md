This example configures a [Keycloak](https://www.keycloak.org/) server for adding a client for 
[Netbird](https://docs.netbird.io/selfhosted/identity-providers#keycloak).

## Usage

1. Remove the `.example` extension from the *terraform.tfvars.example* and fill in their values 
   appropriately.
1. Run `tofu init` to initialize OpenTofu.
1. Run `tofu apply` to have OpenTofu create the new realm for Netbird to use.
1. You should see the new realm when you log into Keycloak.


## Definitions
* Service accounts are non-human accounts used by an application or system to access resources or
perform actions without user involvement.