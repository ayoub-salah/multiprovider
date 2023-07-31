//Security Group & ssh key
resource "aws_security_group" "security_group" {
  for_each = var.instances

  name        = "security_group-${each.key}"
  description = "Allow ssh/http/https for inbounded traffic and allow all outbounded traffic "
  vpc_id      = var.vpc_ids[var.vpc_name]

  dynamic "ingress" {
    for_each = toset(each.value.ports)
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

//ssh key 
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.example.public_key_openssh
}


resource "aws_instance" "this" {
  for_each      = var.instances

  subnet_id     = var.subnet_ids[each.value.subnet_name]
  ami           = each.value.ami
  instance_type = each.value.instance_type
  associate_public_ip_address = each.value.public_ip
  user_data = file("./aws_script.sh")
  key_name = "deployer-key"
  vpc_security_group_ids = [aws_security_group.security_group[each.key].id]
  tags = {
    Name = each.key
  }
depends_on = [ aws_key_pair.deployer ]
}
