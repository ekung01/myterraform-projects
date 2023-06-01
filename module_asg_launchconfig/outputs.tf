/*output "instance_ids" {
  value = aws_instance.project3-intance[*].id
}
*/
output "alb_sg_id" {
  value = aws_default_security_group.alb_sg.id
}

output "myweb_sg_id" {
  value = aws_security_group.myweb_sg.id
}