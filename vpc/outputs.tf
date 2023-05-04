output "subnet_id" {
  value = aws_subnet.mantle.id
}

output "security_group_id" {
  value = aws_security_group.tectonic.id
}