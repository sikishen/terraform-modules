variable "REGION-PREFIX" {
  default = "awssg"
}
variable "TIER" {
  default = "staging"
}
module "monitor" {
    instance_count         = 1
    source                 = "./modules/ec2-instance-amazon"
    name                   = "${var.REGION-PREFIX}-monitor"
    instance_type          = "m5.xlarge"
    ami                    = data.aws_ami.amazon-linux-ami.id
    subnet_id              = "${aws_subnet.monitoring-subnet.id}"
    key_name               = "staging_private"
    user_data_name         = "user_data-jenkins-slave.sh"
    vpc_security_group_ids = [
        aws_security_group.common-sg.id,
        aws_security_group.portal-sg.id,
        aws_security_group.meta-sg.id,
        aws_security_group.zk-global-sg.id,
        aws_security_group.openapi-sg.id,
    ]
    tags = {
        Terraform   = "true"
        Tier        = "${var.TIER}"
        Owner       = "SEG"
        Service     = "Monitor"
        Deploy      = "true"
    }
}