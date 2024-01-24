resource "null_resource" "cleanup" {
  provisioner "local-exec" {
    command = "find / -type d -name '.terraform' -exec rm -rf {} \\;"
  }
}
