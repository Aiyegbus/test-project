resource "aws_instance" "test_instance" {
  ami           = var.ami_id
  count         = var.number_of_instances
  instance_type = var.instance_type
  key_name      = var.ami_key_pair_name
  subnet_id     = aws_subnet.main_sub[count.index].id

  security_groups = [aws_security_group.loadbalancer.id]

  user_data = file("user_data.sh")
  # Additional EC2 instance configuration, e.g., user data, tags, etc.

  tags = {
    Name = "ayotf-ec2-instance"
  }
}

