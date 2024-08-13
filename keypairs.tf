resource "aws_key_pair" "profilekey" {
	key_name = "profilekey"
	public_key = file(var.PUB_KEY_PATH)
}
