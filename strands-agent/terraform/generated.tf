# # __generated__ by Terraform
# # Please review these resources and move them into your main configuration files.

# # __generated__ by Terraform
# resource "aws_bedrockagent_prompt" "prompt" {
#   customer_encryption_key_arn = null
#   default_variant             = "variantOne"
#   description                 = null
#   name                        = "sakai-test"
#   region                      = "us-east-1"
#   tags                        = null
#   variant {
#     additional_model_request_fields = null
#     model_id                        = null
#     name                            = "variantOne"
#     template_type                   = "TEXT"
#     inference_configuration {
#       text {
#         max_tokens     = null
#         stop_sequences = null
#         temperature    = null
#         top_p          = null
#       }
#     }
#     template_configuration {
#       text {
#         text = "This is my first text prompt. Please summarize on {{topic}}."
#         input_variable {
#           name = "topic"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform
# # Please review these resources and move them into your main configuration files.

# # __generated__ by Terraform
# resource "aws_bedrockagent_flow" "example" {
#   customer_encryption_key_arn = null
#   description                 = null
#   execution_role_arn          = "arn:aws:iam::421109614497:role/service-role/AmazonBedrockExecutionRoleForFlows_DT7UYXFFUK"
#   name                        = "sakai-sandbox-ai-agent-flow"
#   region                      = "us-east-1"
#   tags                        = null
#   definition {
#     connection {
#       name   = "FlowInputNodeFlowInputNode0ToKnowledgeBaseNode_1KnowledgeBaseNode0"
#       source = "FlowInputNode"
#       target = "KnowledgeBaseNode_1"
#       type   = "Data"
#       configuration {
#         data {
#           source_output = "document"
#           target_input  = "retrievalQuery"
#         }
#       }
#     }
#     connection {
#       name   = "KnowledgeBaseNode_1KnowledgeBaseNode0ToPrompt_1PromptsNode0"
#       source = "KnowledgeBaseNode_1"
#       target = "Prompt_1"
#       type   = "Data"
#       configuration {
#         data {
#           source_output = "retrievalResults"
#           target_input  = "topic"
#         }
#       }
#     }
#     connection {
#       name   = "Prompt_1PromptsNode0ToFlowOutputNodeFlowOutputNode0"
#       source = "Prompt_1"
#       target = "FlowOutputNode"
#       type   = "Data"
#       configuration {
#         data {
#           source_output = "modelCompletion"
#           target_input  = "document"
#         }
#       }
#     }
#     node {
#       name = "FlowInputNode"
#       type = "Input"
#       configuration {
#         input {
#         }
#       }
#       output {
#         name = "document"
#         type = "String"
#       }
#     }
#     node {
#       name = "FlowOutputNode"
#       type = "Output"
#       configuration {
#         output {
#         }
#       }
#       input {
#         category   = null
#         expression = "$.data"
#         name       = "document"
#         type       = "String"
#       }
#     }
#     node {
#       name = "KnowledgeBaseNode_1"
#       type = "KnowledgeBase"
#       configuration {
#         knowledge_base {
#           knowledge_base_id = "EQDGIRUYNM"
#           model_id          = null
#           number_of_results = null
#         }
#       }
#       input {
#         category   = null
#         expression = "$.data"
#         name       = "retrievalQuery"
#         type       = "String"
#       }
#       output {
#         name = "retrievalResults"
#         type = "Array"
#       }
#     }
#     node {
#       name = "Prompt_1"
#       type = "Prompt"
#       configuration {
#         prompt {
#           source_configuration {
#             inline {
#               additional_model_request_fields = null
#               model_id                        = "amazon.nova-lite-v1:0"
#               template_type                   = "TEXT"
#               inference_configuration {
#                 text {
#                   max_tokens     = 512
#                   stop_sequences = []
#                   temperature    = 0.699999988079071
#                   top_p          = 0.8999999761581421
#                 }
#               }
#               template_configuration {
#                 text {
#                   text = "あなたはラッパーのFakeTypeです。\n受け取った文章をFakeTypeの歌詞調に変換して400文字程度で返してください。\n {{topic}}."
#                   input_variable {
#                     name = "topic"
#                   }
#                 }
#               }
#             }
#           }
#         }
#       }
#       input {
#         category   = null
#         expression = "$.data"
#         name       = "topic"
#         type       = "Array"
#       }
#       output {
#         name = "modelCompletion"
#         type = "String"
#       }
#     }
#   }
# }
# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "AmazonBedrockExecutionRoleForFlows_DT7UYXFFUK"
resource "aws_iam_role" "example" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Condition = {
        ArnLike = {
          "aws:SourceArn" = "arn:aws:bedrock:us-east-1:421109614497:flow/UC1FQUIGLI"
        }
        StringEquals = {
          "aws:SourceAccount" = "421109614497"
        }
      }
      Effect = "Allow"
      Principal = {
        Service = "bedrock.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "AmazonBedrockExecutionRoleForFlows_DT7UYXFFUK"
  name_prefix           = null
  path                  = "/service-role/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
}
