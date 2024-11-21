resource "aws_instance" "db" {
    
    ami = "ami-09c813fb71547fc4f"
    vpc_security_group_ids = ["sg-0e9b9d879e1385874"]
    instance_type = "t3.micro"
    #provisioners will run when yoou are creating 
    provisioner "local-exec" {
    command = "echo ${self.private_ip} > private_ips.txt"
    }

    # provisioner "local-exec" {
    #     command = "ansible-playbook -i private_ips.txt web.yaml"

    # }

    connection {
        type     = "ssh"
        user     = "ec2-user"
        password = "DevOps321"
        host     = self.public_ip
    }
    provisioner "remote-exec" {
    inline = [
        "sudo dnf install ansible -y",
        "sudo dnf install nginx -y",
        "sudo systemctl start nginx"

    ]
  }


}