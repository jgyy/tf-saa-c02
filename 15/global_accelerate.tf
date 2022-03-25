resource "aws_globalaccelerator_accelerator" "example" {
  name            = "MyFirstAccelerator"
  ip_address_type = "IPV4"
  enabled         = true
}

resource "aws_globalaccelerator_listener" "example" {
  accelerator_arn = aws_globalaccelerator_accelerator.example.id
  client_affinity = "NONE"
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }
}

resource "aws_globalaccelerator_endpoint_group" "singapore" {
  listener_arn                  = aws_globalaccelerator_listener.example.id
  health_check_port             = 80
  health_check_protocol         = "HTTP"
  health_check_path             = "/"
  health_check_interval_seconds = 10
  threshold_count               = 3
  endpoint_group_region         = "ap-southeast-1"

  endpoint_configuration {
    client_ip_preservation_enabled = true
    endpoint_id                    = aws_instance.singapore.id
    weight                         = 100
  }
}

resource "aws_globalaccelerator_endpoint_group" "sydney" {
  listener_arn                  = aws_globalaccelerator_listener.example.id
  health_check_port             = 80
  health_check_protocol         = "HTTP"
  health_check_path             = "/"
  health_check_interval_seconds = 10
  threshold_count               = 3
  endpoint_group_region         = "ap-southeast-2"

  endpoint_configuration {
    client_ip_preservation_enabled = true
    endpoint_id                    = aws_instance.sydney.id
    weight                         = 128
  }
}

resource "aws_globalaccelerator_endpoint_group" "tokyo" {
  listener_arn                  = aws_globalaccelerator_listener.example.id
  health_check_port             = 80
  health_check_protocol         = "HTTP"
  health_check_path             = "/"
  health_check_interval_seconds = 10
  threshold_count               = 3
  endpoint_group_region         = "ap-northeast-1"

  endpoint_configuration {
    client_ip_preservation_enabled = true
    endpoint_id                    = aws_instance.tokyo.id
    weight                         = 128
  }
}
