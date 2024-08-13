terraform {
	backend "s3" {
	 bucket = "terra-profile-state007"
	 key = "terraform/backend"
	 region = "eu-north-1"
	}
}
