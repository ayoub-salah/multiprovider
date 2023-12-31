#VPC module call
module "my_vpc" {
  source = "../modules/vpc/gcp"

  #Vpcs Input
  vpcs = {
    "vpc1" = {
      name   = "vpc1"    
    },
    "vpc2" = {
      name   = "vpc2"
    },
    "vpc3" = {
      name   = "vpc3"
    }
  }

}


#Subnet module call
module "my_subnet" {
  source = "../modules/subnets/gcp"
  depends_on = [module.my_vpc]    #this module starts after vpc module finishes executing 
  
  #Subnets Input
  subnets = {
    "subnet1" = {
      name = "sub1"
      ip_cidr_range = "10.169.0.0/20"
      region = "us-east1"
      vpc_name = "vpc2"
    },
    "subnet2" = {
      name = "sub2"
      ip_cidr_range = "10.167.0.0/20"
      region = "us-east1"
      vpc_name = "vpc1"
    }
  }
}


#Vm module call
module "my_vms" {
  source = "../modules/vm/gcp"
  depends_on = [module.my_vpc, module.my_subnet] #this module starts after vpc & subnet modules finish executing 
  network = "vpc2"    #Vpc name
  
  #Vms Input
  vms = {
    "vm1" = {
      name = "vm1"
      image = "debian-cloud/debian-11"
      type = "e2-medium"
      ports = ["80","22","443"]
      zone = "us-east1-b"
      subnet = "sub1"
      userdata_script = "script.sh"
    },
    "vm2" = {
      name = "vm2"
      image = "debian-cloud/debian-11"
      type = "custom-2-8192"
      ports = ["22"]
      zone = "us-east1-b"
      subnet = "sub1"
      userdata_script = "script.sh"
    }

  }
}

#Output of the vms public IPs
output "vm_ip_out" {
  value = module.my_vms.vm_ips   
}
module "vpc" {
  source = "../modules/vpc/azure"
  # rg     = var.rg
  vpcs = {
    "vpc1" = {
      name              = "vpc1"
      address_space     = ["10.0.0.0/16"]
      availability_zone = var.availability_zone
      resource_group    = var.rg
    },
    "vpc2" = {
      name              = "vpc2"
      address_space     = ["10.1.0.0/16"]
      availability_zone = var.availability_zone
      resource_group    = var.rg

    }

  }

}

module "subnet" {
  source = "../modules/subnet/azure"
  subnets = {
    subnet1 = {
      name           = "subnet1"
      cidr_block     = ["10.0.2.0/24"]
      resource_group = var.rg
      vpc_name       = module.vpc.vpc_name["vpc1"]
    },
    subnet2 = {
      name           = "subnet2"
      cidr_block     = ["10.1.3.0/24"]
      resource_group = var.rg
      vpc_name       = module.vpc.vpc_name["vpc2"]
    },
    subnet5 = {
      name           = "subnet5"
      cidr_block     = ["10.1.4.0/24"]
      resource_group = var.rg
      vpc_name       = module.vpc.vpc_name["vpc2"]
    }
  }
}

module "vms" {
  source = "../modules/vm/azure"

  vms = {
    "vm1" = {
      name                                   = "myVm1"
      resource_group                         = var.rg
      availability_zone                      = "East US"
      size                                   = "Standard_F2"
      admin_username                         = "adminuser"
      disable_password_authentication        = false
      admin_password                         = "Abc_123###"
      public_ip                              = true
      subnet_id                              = module.subnet.subnet_ids["subnet1"]
      private_ip_address_alavailability_zone = "Dynamic"
      myscript                               = file("./myScript.sh")
      rule = {
        priority   = 120,
        open_ports = tolist(["80"])
      }
    },
    "vm2" = {
      name                                   = "myVm2"
      resource_group                         = var.rg
      availability_zone                      = "East US"
      size                                   = "Standard_F2"
      admin_username                         = "adminuser"
      disable_password_authentication        = false
      admin_password                         = "Abc_123###"
      public_ip                              = true
      subnet_id                              = module.subnet.subnet_ids["subnet1"]
      private_ip_address_alavailability_zone = "Dynamic"
      myscript                               = file("./myScript.sh")
      rule = {
        priority   = 130,
        open_ports = tolist([443, 8080])
      }
    },
    "vm3" = {
      name                                   = "myVm3"
      resource_group                         = var.rg
      availability_zone                      = "East US"
      size                                   = "Standard_F2"
      admin_username                         = "adminuser"
      disable_password_authentication        = false
      admin_password                         = "Abc_123###"
      public_ip                              = false
      subnet_id                              = module.subnet.subnet_ids["subnet2"]
      private_ip_address_alavailability_zone = "Dynamic"
      myscript                               = file("./myScript.sh")
      rule = {
        priority   = 140,
        open_ports = tolist([80, 252])
      }

    }
  }
}

resource "azurerm_public_ip" "natPubIP" {
  name                = "nat-gateway-publicIP"
  location            = var.availability_zone
  resource_group_name = var.rg
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}
resource "azurerm_nat_gateway" "nat" {
  name                    = "nat-Gateway"
  location                = var.availability_zone
  resource_group_name     = var.rg
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}
resource "azurerm_nat_gateway_public_ip_association" "pubIpAssocNat" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.natPubIP.id
}
resource "azurerm_subnet_nat_gateway_association" "subnetNatAssoc" {
  subnet_id      = module.subnet.subnet_ids["subnet2"]
  nat_gateway_id = azurerm_nat_gateway.nat.id
}

resource "azurerm_public_ip" "agwIP" {
  name                = "agwPubIPterraform"
  resource_group_name = var.rg
  location            = var.availability_zone
  allocation_method   = "Static"
  sku = "Standard"
}

locals {
  backend_address_pool_name      = "${module.vpc.vpc_name["vpc1"]}-backendPool"
  frontend_port_name             = "${module.vpc.vpc_name["vpc1"]}-feport"
  frontend_ip_configuration_name = "${module.vpc.vpc_name["vpc1"]}-feip"
  http_setting_name              = "${module.vpc.vpc_name["vpc1"]}-be-htst"
  listener_name                  = "${module.vpc.vpc_name["vpc1"]}-httplstn"
  request_routing_rule_name      = "${module.vpc.vpc_name["vpc1"]}-rqrt"
  redirect_configuration_name    = "${module.vpc.vpc_name["vpc1"]}-rdrcfg"
}


resource "azurerm_application_gateway" "network" {
  name                = "myAppgatewayTerraform"
  resource_group_name = var.rg
  location            = var.availability_zone
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  # autoscale_configuration {
  #   min_capacity = 0
  #   max_capacity = 10
  # }
  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = module.subnet.subnet_ids["subnet5"]
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.agwIP.id
    # subnet_id = module.subnet.subnet_ids["subnet2"]
    private_ip_address_allocation = "Dynamic"
  }

  backend_address_pool {

    name = local.backend_address_pool_name // here i must do changes to map vms private ips 
    # ip_addresses = [azurerm_public_ip.PublicIP[0].ip_address, azurerm_public_ip.PublicIP[1].ip_address]
    # ip_addresses = azurerm_network_interface.nic[0].ip_configuration[0].subnet_id
    ip_addresses = ["10.1.3.4"]
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    #path                                = "/"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 20
    pick_host_name_from_backend_address = true
    probe_name                          = "myProbe"


  }
  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority                   = 1
  }
  probe {
    # host                                      = "127.0.0.1"
    name                                      = "myProbe"
    interval                                  = 30
    protocol                                  = "Http"
    path                                      = "/"
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true

  }

   
}




resource "azurerm_monitor_action_group" "actionGrp" {
  name                = "monitor-actiongroup"
  resource_group_name = var.rg

  short_name = "myAct"

  email_receiver {
    name          = "mailTosend"
    email_address = "sidahmed.tafifet@infraxcode.com"
  }
}
resource "azurerm_monitor_metric_alert" "metric" {
  name                = "monitor-metricalert"
  resource_group_name = var.rg
  scopes              = [azurerm_application_gateway.network.id]
  description         = "Action will be triggered when more than 10 request/minute  to the app."

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "TotalRequests"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 10
    skip_metric_validation  = true
  
}
}

module "vpc_aws" {
  source  = "../modules/vpc/aws"
  vpcs = {
    vpc1 = {cidr_block = ["192.168.1.0/24"]},
    vpc2 = {cidr_block = ["192.168.2.0/24"]},
    vpc3 = {cidr_block = ["192.168.3.0/24"]},
  }
}

module "subnets_public_aws" {
  source  = "../modules/subnets/aws"
  //internet_gateway_id = module.vpc_aws[0].internet_gateway_ids[var.vpc_id]
  vpc_ids = module.vpc_aws.vpc_ids
  internet_gateway_ids = module.vpc_aws.internet_gateway_ids
  route_ids = module.vpc_aws.route_table_ids
  subnets = {
    public_subnet_1  = { cidr_block = ["192.168.1.0/26"], availability_zone = "us-east-1a", map_public_ip = true, vpc_name = "vpc1" },
    public_subnet_2  = { cidr_block = ["192.168.1.64/26"], availability_zone = "us-east-1b", map_public_ip = true, vpc_name = "vpc1"},

  }
}

module "subnets_private_aws" {
  source  = "../modules/subnets/aws"
  vpc_ids = module.vpc_aws.vpc_ids
  internet_gateway_ids = module.vpc_aws.internet_gateway_ids
  route_ids = module.vpc_aws.route_table_ids
  subnets = {
    private_subnet_1  = { cidr_block = ["192.168.1.128/26"], availability_zone = "us-east-1a", map_public_ip = false, vpc_name = "vpc1" },
    private_subnet_2  = { cidr_block = ["192.168.1.192/26"], availability_zone = "us-east-1b", map_public_ip = false, vpc_name = "vpc1"},
  }
}

resource "aws_eip" "this" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.this.id
  subnet_id     = module.subnets_public_aws.subnet_ids["public_subnet_1"]

}

//**************************************************************

resource "aws_route_table" "route_table_private_1" {
  vpc_id = module.vpc_aws.vpc_ids["vpc1"]

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = module.subnets_private_aws.subnet_ids["private_subnet_1"]
  route_table_id = aws_route_table.route_table_private_1.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = module.subnets_private_aws.subnet_ids["private_subnet_2"]
  route_table_id = aws_route_table.route_table_private_1.id
}

//*****************************************************************


module "vms_aws" {
  source = "../modules/vm/aws"
  vpc_name = "vpc1"
  vpc_ids = module.vpc_aws.vpc_ids
  subnet_ids = module.subnets_private_aws.subnet_ids
  instances = {
    instance_1 = { ami = "ami-022e1a32d3f742bd8", instance_type = "t2.micro", subnet_name = "private_subnet_1", public_ip = false, ports = [22,80,443] },
    instance_2 = { ami = "ami-022e1a32d3f742bd8", instance_type = "t2.micro", subnet_name = "private_subnet_1", public_ip = false, ports = [22,80,443] },
  }
  depends_on = [
    aws_route_table.route_table_private_1
  ]
}



//********************************************************************
resource "aws_lb" "alb_1" {
  name               = "ayoub-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups      = [module.vms_aws.security_group_ids["instance_1"]]
  subnets            = [module.subnets_public_aws.subnet_ids["public_subnet_1"] , module.subnets_public_aws.subnet_ids["public_subnet_2"]]
}

resource "aws_lb_target_group" "target_group_1" {
  name     = "TargetGroup1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc_aws.vpc_ids["vpc1"]

  health_check {
    enabled             = true
    interval            = 120
    path                = "/"
    port                = "traffic-port"
    timeout             = 119
    healthy_threshold   = 10
    unhealthy_threshold = 10
  }
}

resource "aws_lb_listener" "listener_1" {
  load_balancer_arn = aws_lb.alb_1.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_1.arn
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachment_1" {
  target_group_arn = aws_lb_target_group.target_group_1.arn
  target_id        = module.vms_aws.instance_ids["instance_1"]
  port             = 80
}

resource "aws_lb_target_group_attachment" "target_group_attachment_2" {
  target_group_arn = aws_lb_target_group.target_group_1.arn
  target_id        = module.vms_aws.instance_ids["instance_2"]
  port             = 80
}

output "alb_dns" {
  value = aws_lb.alb_1.dns_name
}
