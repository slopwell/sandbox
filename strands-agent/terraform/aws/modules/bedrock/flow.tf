
# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_bedrockagent_prompt" "prompt" {
  customer_encryption_key_arn = null
  default_variant             = "variantOne"
  description                 = null
  name                        = "${var.namespace}-test"
  variant {
    additional_model_request_fields = null
    model_id                        = local.llm_model
    name                            = "variantOne"
    template_type                   = "TEXT"
    inference_configuration {
      text {
        max_tokens     = 512
        stop_sequences = ""
        temperature    = 0.699999988079071
        top_p          = 0.8999999761581421
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

resource "aws_bedrockagent_flow" "flow" {
  customer_encryption_key_arn = null
  description                 = null
  execution_role_arn          = "arn:aws:iam::421109614497:role/service-role/AmazonBedrockExecutionRoleForFlows_DT7UYXFFUK"
  name                        = "${var.namespace}-ai-agent-flow"
  region                      = "us-east-1"
  tags                        = null
  definition {
    connection {
      name   = "FlowInputNodeFlowInputNode0ToKnowledgeBaseNode_1KnowledgeBaseNode0"
      source = "FlowInputNode"
      target = "KnowledgeBaseNode_1"
      type   = "Data"
      configuration {
        data {
          source_output = "document"
          target_input  = "retrievalQuery"
        }
      }
    }
    connection {
      name   = "KnowledgeBaseNode_1KnowledgeBaseNode0ToPrompt_1PromptsNode0"
      source = "KnowledgeBaseNode_1"
      target = "Prompt_1"
      type   = "Data"
      configuration {
        data {
          source_output = "retrievalResults"
          target_input  = "topic"
        }
      }
    }
    connection {
      name   = "Prompt_1PromptsNode0ToFlowOutputNodeFlowOutputNode0"
      source = "Prompt_1"
      target = "FlowOutputNode"
      type   = "Data"
      configuration {
        data {
          source_output = "modelCompletion"
          target_input  = "document"
        }
      }
    }
    node {
      name = "FlowInputNode"
      type = "Input"
      configuration {
        input {
        }
      }
      output {
        name = "document"
        type = "String"
      }
    }
    node {
      name = "FlowOutputNode"
      type = "Output"
      configuration {
        output {
        }
      }
      input {
        category   = null
        expression = "$.data"
        name       = "document"
        type       = "String"
      }
    }
    node {
      name = "KnowledgeBaseNode_1"
      type = "KnowledgeBase"
      configuration {
        knowledge_base {
          knowledge_base_id = aws_bedrockagent_knowledge_base.bedrock_knowledge_base_v2.id
          model_id          = null
          number_of_results = null
        }
      }
      input {
        category   = null
        expression = "$.data"
        name       = "retrievalQuery"
        type       = "String"
      }
      output {
        name = "retrievalResults"
        type = "Array"
      }
    }
    node {
      name = "Prompt_1"
      type = "Prompt"
      configuration {
        prompt {
          source_configuration {
            inline {
              additional_model_request_fields = null
              model_id                        = local.llm_model
              template_type                   = "TEXT"
              inference_configuration {
                text {
                  max_tokens     = 512
                  stop_sequences = []
                  temperature    = 0.699999988079071
                  top_p          = 0.8999999761581421
                }
              }
              template_configuration {
                text {
                  text = "あなたは著名なポエマーです。受け取った文章をポエミーにしてください。\n {{topic}}."
                  input_variable {
                    name = "topic"
                  }
                }
              }
            }
          }
        }
      }
      input {
        category   = null
        expression = "$.data"
        name       = "topic"
        type       = "Array"
      }
      output {
        name = "modelCompletion"
        type = "String"
      }
    }
  }
}
