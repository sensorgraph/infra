# Project to use for create all the SensorGraph infrastructure 

## How to create/destroy the infrastructure

### 1. Initialise you environmernt

```shell
aws configure
```

### 2. Create the infrastructure

```shell
terraform apply
```

### 3. Destroy the infrastructure

```shell
terraform destroy
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability\_zones | By default we use only 2 AZs on Paris | list | `[ "eu-west-3a", "eu-west-3b" ]` | no |
| aws\_region | Region to use for create the infrastructure (default: Paris) | string | `"eu-west-3"` | no |
| private\_cidr | The both IPs range used in the private subnet | list | `[ "10.0.0.0/26", "10.0.0.64/26" ]` | no |
| public\_cidr | The both IPs range useds in the public subnet | list | `[ "10.0.0.128/26", "10.0.0.192/26" ]` | no |
| name | Default tags name to be applied on the infrastructure for the resources names| map | `...` | no |
| tags | Default tags to be applied on the infrastructure | map | `...` | no |
| vpc\_cidr | IP range to use on the VPC (default: 256 IPs) | string | `"10.0.0.0/24"` | no |

## Outputs

| Name | Description |
|------|-------------|
| availability\_zones | The AZs to be used on the infrastructure |
| bucket\_name\_accesslog\_bucket  | Bucket to use for logging the acceslogs for the others Bucket |
| private\_subnet\_id | The IDs of private subnets |
| public\_subnet\_id | The IDs of public subnets |
| vpc\_id | The ID of main VPC |

## AWS architecture diagram

Use this file [files/drawio/infra.xml](files/drawio/infra.xml) on this site [https://www.draw.io](https://www.draw.io) if you need to contribute to the diagram.

![files/drawio/infra.png](files/drawio/infra.png)

> Note: The `NAT Gateway` is not yet implemented

## Author

* [**Mohamed BASRI**](https://github.com/mbasri)

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details
