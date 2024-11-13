resource "aws_security_group" "sg" {
      name        = "${var.component_name}-${var.env}-sg"
        description = "inbound allow for ${var.component_name}"


    ingress {
          from_port       = 22
          to_port         = 22
          protocol        = "TCP"
          cidr_blocks      = ["0.0.0.0/0"]
        }


    ingress {
        from_port       = var.app_port
        to_port         = var.app_port
        protocol        = "TCP"
        cidr_blocks      = ["0.0.0.0/0"]
      }

    egress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks      = ["0.0.0.0/0"]

    }
  }

  resource "aws_instance" "instance" {
      ami =  data.aws_ami.ami.id
      instance_type = "t3.small"
      vpc_security_group_ids = [ aws_security_group.sg.id ]
      tags = {
          Name = "${var.component_name}-${var.env}"
          }
      }

  resource "null_resource" "ansible-pull"{
       provisioner "remote-exec" {
      connection {
          type     = "ssh"
          user     = "ec2-user"
          password = "DevOps321"
          host     = aws_instance.instance.private_ip
        }


          inline = [
            "sudo labauto ansible",
            "ansible-pull -i localhost, -U https://github.com/omkar8555/roboshop-ansible.1.git  roboshop.yml -e env=${var.env}  -e component=${var.component_name} -e vault_token=${var.vault_token}"
          ]
        }
    }


resource "aws_route53_record" "record" {
  zone_id = var.zone_id
  name    = "${var.component_name}-${var.env}.${var.domain_name}"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.instance.private_ip]
}




