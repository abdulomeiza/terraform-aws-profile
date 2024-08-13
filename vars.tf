variable REGION {
	default = "eu-north-1"
}

variable AMI  {
	type = map
	default = {
		eu-north-1 = "ami-02af70169146bbdd3"
		eu-north-1 = "ami-07c8c1b18ca66bb07"
		us-east-1 =	"ami-04a81a99f5ec58529"
		
	}
}

variable PRIV_KEY_PATH {
	default = "profilekey"
}

variable PUB_KEY_PATH {
	default = "profilekey.pub"
}

variable USERNAME {
	default = "ubuntu"
}

variable IP {
	default = "0.0.0.0/0"
}

variable rmquser {
	default = "rabbit"
}

variable rmqpass {
	default = "Gr33n@pple123456"
}

variable dbuser {
	default = "admin"
}

variable dbpass {
	default = "admin123"
}

variable dbname {
	default = "accounts"
}

variable instance_count {
	default = "1"
}

variable VPC_NAME {
	default = "profile-VPC"
}

variable Zone1 {
	default = "eu-north-1a"
}

variable Zone2 {
	default = "eu-north-1b"
}

variable Zone3 {
	default = "eu-north-1c"
}

variable VpcCIDR {
	default = "172.21.0.0/16"
}

variable PubSubCIDR {
	default = "172.21.1.0/24"
}

variable PubSub2CIDR {
	default = "172.21.2.0/24"
}

variable PubSub3CIDR {
	default = "172.21.3.0/24"
}

variable PrivSub1CIDR {
	default = "172.21.4.0/24"
}

variable PrivSub2CIDR {
	default = "172.21.5.0/24"
}

variable PrivSub3CIDR {
	default = "172.21.6.0/24"
}
