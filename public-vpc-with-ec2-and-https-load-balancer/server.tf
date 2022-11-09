# Create an AWS EC2 instance with its own security group.

# Create security group for the server.
resource "aws_security_group" "my_hello_world_security_group" {
    name        = "myHelloWorldServerSecurityGroup"
    description = "Allows incoming traffic on ports 22 and 80 and unrestricted outgoing traffic."
    vpc_id      = aws_vpc.my_vpc.id

    # Open firewall up to allow everyone to access the server on port 22 for SSH.
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    # Open firewall up to allow everyone to access the webserver on the web port
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Open the server up to allow it to connect outwards to anywhere. E.g. to apply updates etc.
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


resource "aws_instance" "my_ec2_server" {
    ami = var.ami
    instance_type = "t3a.micro"

    # Ensure the instance deploys to a subnet that is within our custom VPC
    subnet_id = aws_subnet.my_vpc_subnet.id
    
    # Set the security group to the one we defined above.
    vpc_security_group_ids = [aws_security_group.my_hello_world_security_group.id]

    # When the server starts, run our cloud init configuration file with the variables 
    # substituted in rendering. If there were no variables, you could just load the file
    # directly with 'user_data = file("./cloud-init.conf")'
    user_data = templatefile("./cloud-init.yml", {
        ssh_public_key = var.ssh_public_key
        web_port = 80
    })

    # Tag the server so we will recognize it when we log into the web console
    tags = {
        Name = "mySimplyDeployedEc2Server"
    }
}


# Create an elastic IP and assign it to the server.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
resource "aws_eip" "my_elastic_ip" {
    instance = aws_instance.my_ec2_server.id
    vpc      = true
}