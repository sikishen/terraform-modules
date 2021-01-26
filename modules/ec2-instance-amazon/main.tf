resource "aws_instance" "this" {
    count                  = var.instance_count
    ami                    = var.ami
    instance_type          = var.instance_type
    subnet_id              = var.subnet_id
    key_name               = var.key_name
    vpc_security_group_ids = var.vpc_security_group_ids
    dynamic "root_block_device" {
        for_each = var.root_block_device
        content {
            delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
            volume_size           = lookup(root_block_device.value, "root_volume_size", null)
            volume_type           = lookup(root_block_device.value, "root_volume_type", null)
        }
    }
    dynamic "ebs_block_device" {
        for_each = var.ebs_block_device
        content {
            delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
            volume_size           = lookup(ebs_block_device.value, "data_volume_size", null)
            volume_type           = lookup(ebs_block_device.value, "data_volume_type", null)
            device_name           = lookup(ebs_block_device.value, "data_device_name", null)
            snapshot_id           = lookup(ebs_block_device.value, "data_snapshot_id", null)            
        }
    }
    user_data = "${file("${path.module}/scripts/${var.user_data_name}")}"

    tags = merge(
        {
           "Name" = var.instance_count > 1 || var.use_num_suffix ? format("%s-%d", var.name, count.index + 1) : var.name
        },
        var.tags,
    )
    depends_on = [var.module_depends_on]
}

