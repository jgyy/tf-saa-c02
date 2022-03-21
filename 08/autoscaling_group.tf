resource "aws_autoscaling_group" "demo-asg" {
  name                      = "DemoASG"
  vpc_zone_identifier       = [for subnet in data.aws_subnets.abc.ids : subnet]
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "ELB"

  launch_template {
    id = aws_launch_template.foobar.id
  }
}

resource "aws_launch_template" "foobar" {
  name_prefix            = "MyDemoTemplate"
  description            = "TemplateDemo"
  image_id               = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ec2.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  user_data              = base64encode(file("ec2_user_data.sh"))
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.demo-asg.id
  alb_target_group_arn   = aws_lb_target_group.alb-target.arn
}
