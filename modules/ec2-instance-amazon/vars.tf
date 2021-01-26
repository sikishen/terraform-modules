variable "name" {}
variable "ami" {
    default = "ami-08d4ad2541b0f0b0d"
}
variable "instance_type" {
    default = "t2.micro"
}
variable "subnet_id" {}
variable "key_name" {}
variable "vpc_security_group_ids" {}
variable "root_block_device" {
    type    = list(map(string))
    default = [
        {
            root_volume_type = "gp2"
            root_volume_size = 100
            delete_on_termination = true
        },
    ]
}
variable "ebs_block_device" {
    type    = list(map(string))
    default = [
        {
            data_volume_type = "gp2"
            data_volume_size = 500
            data_device_name = "/dev/sdb"
            delete_on_termination = true
        },
    ]
}
variable "root_volume_type" {
    default = "gp2"
}
variable "root_volume_size" {
    default = "50"
}
variable "data_volume_type" {
    default = "gp2"
}
variable "data_volume_size" {
    default = "100"
}
variable "data_device_name" {
    default = "/dev/sdb"
}
variable "tags" {}
variable "instance_count" {}
variable "use_num_suffix" {
    type    = bool
    default = true
}
variable "user_data_name" {
    default = "user_data-default.sh"
}
variable "module_depends_on" {
    default = [""]
}