resource "aws_bedrockagent_agent" "bedrock_agent" {
  agent_name                  = "${var.namespace}-agent-v2"
  agent_resource_role_arn     = aws_iam_role.agent_role.arn
  idle_session_ttl_in_seconds = 500
  foundation_model            = local.llm_model
  instruction                 = "You are a helpful AI assistant that can answer questions and help with various tasks."
}
