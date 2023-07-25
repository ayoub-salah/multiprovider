/*
Infrastructure multi-cloud avec Terraform
Ce dépôt contient des modules Terraform pour le déploiement d'une infrastructure sur AWS et Azure.

Contenu du dépôt
main.tf : fichier principal qui utilise les modules pour créer une infrastructure sur AWS et/ou Azure.
vars.tf : contient les variables utilisées dans le main.tf.
modules/vpc/aws : module Terraform pour créer un VPC sur AWS.
modules/vpc/azure : module Terraform pour créer un VPC sur Azure.
modules/subnets/aws : module Terraform pour créer des sous-réseaux dans le VPC AWS.
modules/subnets/azure : module Terraform pour créer des sous-réseaux dans le VPC Azure.
Utilisation
Clonez ce dépôt.

Dans le fichier main.tf, vous pouvez spécifier les modules que vous souhaitez utiliser pour déployer l'infrastructure. Par exemple, si vous souhaitez déployer un VPC sur Azure, vous pouvez utiliser le module vpc_azure comme suit :

module "vpc_azure" {
  count  = var.deploy_azure ? 1 : 0
  source = "../modules/vpc/azure"
  vpcs   = var.vpcs
}
Pour chaque module, vous devez indiquer si vous voulez déployer ou non (avec count), le chemin du module (source) et les variables d'entrée pour ce module.

Si vous ne voulez pas déployer sur Azure, vous pouvez mettre count = 0 ou simplement commenter le bloc entier.

Personnalisation de vars.tf
Le fichier vars.tf contient les variables d'entrée pour votre infrastructure. Vous pouvez modifier ces valeurs par défaut en fonction de vos besoins.

Par exemple, si vous voulez changer les plages d'adresses de vos VPCs, vous pouvez le faire comme suit :

variable "vpcs" {
  description = "Configuration des VPC"
  type        = map(object({
    address_space = list(string)
    location      = string
    resource_group    = string
  }))
  default = {
    vpc1 = {
      address_space = ["10.0.0.0/16"]
      location      = "East US"
      resource_group = "my-resource-group"
    }
  }
}
De même, vous pouvez également spécifier les sous-réseaux que vous souhaitez créer, leur CIDR, la zone de disponibilité, et si l'IP publique doit être mappée ou non.

L'utilisateur doit remplir ces fichiers selon ses besoins spécifiques pour déployer son infrastructure.

Si vous rencontrez des problèmes ou si vous avez besoin de plus de précisions sur certaines parties, n'hésitez pas à demander.


Naviguez jusqu'au dossier app :

cd multicloud/app
Initialisez Terraform :

terraform init
Planifiez l'execution :

terraform plan
Appliquez le plan :

terraform apply
Les variables deploy_aws et deploy_azure dans vars.tf peuvent être utilisées pour contrôler si les ressources doivent être déployées sur AWS ou Azure, respectivement. Par défaut, les deux sont réglés sur true, donc les ressources seront déployées sur les deux cloud. Si vous souhaitez déployer sur un seul cloud, réglez la variable correspondante sur false.

Veuillez noter que vous devrez fournir vos propres informations d'identification pour AWS et Azure pour que Terraform puisse se connecter et créer des ressources sur ces plateformes.

*/