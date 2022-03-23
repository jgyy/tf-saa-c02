data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = ["Default"]
  }
}

data "aws_subnets" "default" {
  filter {
    name   = "tag:Name"
    values = ["Default Public a", "Default Public b", "Default Public c"]
  }
}

resource "aws_elastic_beanstalk_application" "demo" {
  name        = "DemoBeanstalk"
  description = "tf-test-desc"
}

resource "aws_elastic_beanstalk_environment" "demo" {
  name                = "DemoBeanstalk"
  tier                = "WebServer"
  application         = aws_elastic_beanstalk_application.demo.name
  solution_stack_name = "64bit Amazon Linux 2 v5.5.0 running Node.js 16"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = data.aws_vpc.default.id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "True"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", [for subnet in data.aws_subnets.default.ids : subnet])
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.medium"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
}
