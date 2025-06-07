# Providers in Terraform

- A provider is a plugin that lets Terraform manage an external API.
- When we run `terraform init`, plugins required for the provider are automatically downloaded and saved locally to a `.terraform` directory.


# Resources in Terraform
- Resource block describes one or more infrastructure objects.
e.g.
```terraform
resource "aws_instance" "myec2" {
    ami = ""
    instance_type = ""
}
```

- A resource block declares a resource of a given type ("aws_instance") with a given local name ("myec2"). The resource type cannot be changed, but the given local name can.

> [!NOTE]
> Resource type and name together serve as an identifier for a given resource and so must be unique
> You can only use the resource that are supported by a specific provider.

# Provider Namespace
$\textcolor{orange}{\text{Namespaces}}$ are used to help users identify the organization or publisher responsible for the integration.

| Tier       | Description                                                            |
| -----------| -------------                                                          |
| Official   |  hashicorp                                                             |
| Partner    | Third party organization (e.g. mongodb/monogodbatlas)                  |
| Community  | Maintainer's individual or organization account (e.g. DeviaVir/gsuite) |

> [!IMPORTANT]
> Terraform requires explicit source information for any providers that are not HashiCorp-maintained, using a new syntax in the required_providers nested block inside the terraform configuration block.
<table>
<tr>
<td> HashiCorp Maintained </td> <td> Non-HashiCorp Maintained </td>
</tr>
<tr>
<td>

```terraform
provider "aws" {
    region     = "us-west-2"
    access_key = ""
    secret_key = ""
}
```

</td>
<td>

```terraform
terraform {
    required_providers {
        digitalocean = {
            source = "digitalocean/digitalocean"
        }
    }
}

provider "digitalocean" {
    token = "PUT-YOUR-TOKEN-HERE"
}
```

</td>
</tr>
</table>