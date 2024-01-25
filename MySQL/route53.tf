provider "aws" {
    region = "us-east-1"
    access_key= "AKIAW7TLTGPNSLEZTAUM"
    secret_key= "qt+1FLMQ3LL/jKtPwRvI0rlGkxc28BUWUXZVWN9r"
}

resource "aws_route53_record" "example" {
  zone_id = "Z056284239QHHUXN5IEWO"
  name    = "blog.muratgroup.link"
  type    = "A"
  ttl     = 300
  records = [azurerm_public_ip.example.ip_address]
  
}