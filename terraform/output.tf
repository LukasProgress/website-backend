output "visitor_counter_url" {
  value = "${aws_apigatewayv2_api.http_api.api_endpoint}/visits"
  description = "Public URL for the /visits endpoint"
}