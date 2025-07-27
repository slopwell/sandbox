variable "function_name" { type = string }
variable "handler" { type = string }
variable "runtime" { type = string }
variable "filename" { type = string }
variable "layer_filename" { type = string }
variable "environment_variables" { type = map(string) }
variable "iam_policy_json" { type = string }

variable "namespace" { type = string }
