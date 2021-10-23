# Getting started

## Mac

## Step1: Prepare your system

1. Install terraform `brew install terraform && terraform --version`
1. Download and install the AWS cli
1. Create a user in your aws console  with the `AdministratorAccess` policy. The user have an `Access key ID` and a `Secret access key`
1. Configure your computer's awscli to be able to authenticate on aws. Use the previously generated `Access key ID` and `Secret access key`
1. Test `aws s3 ls`. If well configured, it should list your s3 bucket content.


## Step2: Start the deployment

### Terraform init
1. If not already done, clone this repository
1. Step into the aws folder`$cd deployment/examples/aws`
1. Run `$terraform init`. This command will clone the project and down load all the terraform required modules. If executed sucessfuly you should get a message `Terraform has been successfully initialized!`

### Update properties

You can update the file `examples/aws/variables` to reflect your deployement. i.e you can choose to change the region, the prefix, the stage name etc...

```
variable "region" {
  default = "eu-central-1"
}
variable "prefix" {
  default = "DialchainRelay"
}

variable "stage_name" {
  default = "TestEnv"
}

...

variable "container-name" {
  default = "test-env-dial-relay"
}

```

### Plan and Deploy

After changing the properties, run:

```bash
$terraform plan
$terraform apply (enter yes in the prompt)
```

If successfully executed, you should get the following print in the console `Apply complete! Resources: 17 added, 0 changed, 0 destroyed.`

### Removing all deployments

After successfully deployment, you can teardown the infrastructure by running `terraform destroy` (enter yes in the prompt).
If successfully executed, you should get a message `Destroy complete! Resources: 17 destroyed.`