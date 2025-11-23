# import {
#   to = aws_vpc_peering_connection.peering
#   id = "pcx-0f0605801406609b4"
# }

# __generated__ by Terraform from "pcx-0f0605801406609b4"
resource "aws_vpc_peering_connection" "peering" {
  auto_accept = true

  peer_owner_id = "xxx"
  peer_vpc_id   = aws_vpc.main.id
  vpc_id        = aws_vpc.dmz_vpc.id

  tags = {
    Name = "slopwell-sandbox_peering"
  }
  tags_all = {
    Name = "slopwell-sandbox_peering"
  }

  accepter {
    allow_remote_vpc_dns_resolution = false
  }
  requester {
    allow_remote_vpc_dns_resolution = false
  }
}
