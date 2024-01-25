provider "aws" {
    region = "us-east-1"
    access_key= "AKIAW7TLTGPNZFMXNCJE"
    secret_key= "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"
}

resource "aws_route53_record" "wordpress" {
  zone_id = "Z056284239QHHUXN5IEWO"
  name    = "wordpress.muratgroup.link"
  type    = "A"
  ttl     = 300
  records = [azurerm_public_ip.example.ip_address]
}
