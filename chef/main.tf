provider "aws" {
    access_key = "${var.accesskey}"
    secret_key = "${var.secretkey}"
    region = "${var.region}"
}
resource "aws_instance" "web" {  
    provisioner "chef" {
        connection {
        type = "ssh"
        user = "ubuntu"
        private_key = "${file("./anushar.pem")}"
  }
  environment = "_default"   
  run_list = ["tomcat-new::default"]  
  server_url = "https://manage.chef.io/organizations/qt2/"
  node_name = "tomcat"
  recreate_client = true
  user_name = "anushayamana"
  user_key = "${file("./anushayamana.pem")}"
  version = "14.10.9"
  
  }  
   ami = "ami-0a313d6098716f372"
   instance_type = "t2.micro"
   key_name = "anushar"
   security_groups = ["${aws_security_group.allowall.id}"]
   subnet_id = "${aws_subnet.mysubnet.id}"
   associate_public_ip_address = true
   
   tags {
       name = "tomcat"
   }
}
