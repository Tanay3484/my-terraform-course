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
> <table>
> <tr>
> <td> HashiCorp Maintained </td> <td> Non-HashiCorp Maintained </td>
> </tr>
> <tr>
> <td>

```terraform
provider "aws" {
    region     = "us-west-2"
    access_key = ""
    secret_key = ""
}
```

> </td>
> <td>

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

> </td>
> </tr>
> </table>

# Learning to Destroy Resources
If you keep the infrastructre running, you will get charged for it.

Hence it is important for us to also know on how we can delete the infrastructre resources created via terraform.

## Approach 1 - Destroy ALL
`terraform destroy` allows us to destroy all the resource that are created within the folder.

## Approach 2 - Destroy Some
terraform destroy with `-target flag` allows us to destroy specific resource. <br/>
The `-target` option can be used to focus Terraform's attention on only a subset of resources.<br/>
Combination of : Resource Type + Local Resource name.
<br/>
In our example:

|Resource Type    | Local Resource Name    |
|-----------------| -----------------------|
|aws_instance     | myec2                  |
|github_repository| terraform-example-repo |

<br/>

The below example deletes only the github repo.
```
terraform destroy -target github_repository.terraform-example-repo
```

# State File
Terraform stores the state of the infrastructure that is being created from the TF files.<br/>
This state allows terraform to map real world resource to your existing configuration.<br/>
> [!TIP]
> When you destory a resource, the associated state file of that resource is destroyed as well.

# Desired & Current State

## Desired State
- Terraform's primary function is to create, modify, and destroy infrastructure resources to match the desired state described in a Terraform configuration.
- Desired state is the state defined in your terraform file. For example if you are trying to create an EC2 instance, the desired state as defined in your code will be : 
```terraform
resource "aws_instance" "myec2" {
    ami           = "ami-<hexa no.>"
    instance_type = "t2.micro"
}
```

## Current State
- Current state is the actual state of a reasource that is currently deployed.
> [!NOTE]
> It is not always considered that Desired State == Current State
> For e.g., you might have the `instance_type` as `t2.micro` in your Desired state, but someone could manually edit the instance type from AWS UI, in which case your Desired State != Current State.

> [!IMPORTANT]
> Terraform tries to ensure that the deployed infrastructre is based on the desired state.
> If there is a difference between the two, `terraform plan` presents a description of the changes necessary to achieve the desired state.