# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_bedrockagent_prompt" "prompt" {
  customer_encryption_key_arn = null
  default_variant             = "variantOne"
  description                 = null
  name                        = "sakai-test"
  region                      = "us-east-1"
  tags                        = null
  variant {
    additional_model_request_fields = null
    model_id                        = null
    name                            = "variantOne"
    template_type                   = "TEXT"
    inference_configuration {
      text {
        max_tokens     = null
        stop_sequences = null
        temperature    = null
        top_p          = null
      }
    }
    template_configuration {
      text {
        text = "This is my first text prompt. Please summarize on {{topic}}."
        input_variable {
          name = "topic"
        }
      }
    }
  }
}
