# Providers in Terraform

- A provider is a plugin that lets Terraform manage an external API.
- When we run `terraform init`, plugins required for the provider are automatically downloaded and saved locally to a `.terraform` directory.


# Resources in Terraform
- Resource block describes one or more infrastructure objects.
e.g.
```hcl
resource "aws_instance" "myec2" {
    ami = ""
    instance_type = ""
}
```

- A resource block declares a resource of a given type ("aws_instance") with a given local name ("myec2"). The resource type cannot be changed, but the given local name can.

> [!NOTE]
> Resource type and name together serve as an identifier for a given resource and so must be unique
> You can only use the resource that are supported by a specific provider.