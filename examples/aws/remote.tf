terraform {
  backend "s3" {
    bucket="keepid-dev-state"
    key="ecs/dev-state.tfstate"
    dynamodb_table="dev-state-lock"
  }
}