
resource "vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Test VPC"
  }
}

resource "aws_subnet" "test_subnet1" {
    vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-west-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "Test Subnet 1"
  }
}

resource "aws_subnet" "test_subnet2" {
    vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-west-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "Test Subnet 2"
  }
}

resource "aws_instance" "test_instance" {
  ami           = "ami-0f8e81a3da6e2510a" # Ubuntu 20.04 LTS AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.test_subnet1.id # Associate with the public subnet
  subnet_id     = aws_subnet.test_subnet2.id # Associate with the public subnet
  key_name      = "ayoterraformkey"        # Replace with the name of your EC2 key pair

  # Additional EC2 instance configuration, e.g., user data, tags, etc.

  tags = {
    Name = "ayotf-ec2-instance-${count.index}"
  }
}

