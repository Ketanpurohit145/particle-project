output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

## ✅ Internet Gateway ID
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

## ✅ NAT Gateway ID (if enabled)
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.this.id
}

## ✅ Elastic IP for NAT Gateway
output "nat_gateway_eip" {
  description = "Elastic IP assigned to the NAT Gateway"
  value       = aws_eip.nat.public_ip
}

## ✅ Public Route Table ID
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}

## ✅ Private Route Table ID
output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private.id
}

# Output Bastion Host Public IP
output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip
  description = "Public IP of the Bastion Host"
}
output "public_subnets" {
  value = aws_subnet.public[*].id
}

 output "bastion_security_group_id" {
   value = aws_security_group.bastion_sg.id
}

