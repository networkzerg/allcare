resource "aws_vpc" "red_global_allacare" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "red_global_allcare"
  }
}

resource "aws_subnet" "publico_allacare" {
  vpc_id     = aws_vpc.red_global_allacare.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name = "publico_allcare"
  }
}

resource "aws_subnet" "privada_allacare" {
  vpc_id     = aws_vpc.red_global_allacare.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "privada_allcare"
  }
}

/*
 Recurso: aws_vpc "red_global_allacare"
Este recurso define una VPC (Virtual Private Cloud) en AWS, que es una red virtual donde puedes lanzar tus recursos AWS.

Atributos Principales

cidr_block: Especifica el rango de direcciones IP para la VPC. En este caso, el bloque CIDR es "10.0.0.0/16".
tags: Etiquetas para identificar la VPC. Aquí se ha añadido una etiqueta con el nombre "red_global_allcare".
Recurso: aws_subnet "publico_allacare"
Este recurso define una subred pública dentro de la VPC. Las instancias lanzadas en esta subred pueden tener direcciones IP públicas.

Atributos Principales

vpc_id: Especifica el ID de la VPC donde se creará la subred. En este caso, se utiliza el ID de la VPC creada anteriormente (aws_vpc.red_global_allacare.id).
cidr_block: Especifica el rango de direcciones IP para la subred. En este caso, el bloque CIDR es "10.0.1.0/24".
map_public_ip_on_launch: Si se establece en true, se asignará automáticamente una dirección IP pública a las instancias lanzadas en esta subred.
availability_zone: Especifica la zona de disponibilidad donde se creará la subred. Aquí se ha seleccionado "us-east-1a".
tags: Etiquetas para identificar la subred. Aquí se ha añadido una etiqueta con el nombre "publico_allcare".
Recurso: aws_subnet "privada_allacare"
Este recurso define una subred privada dentro de la VPC. Las instancias lanzadas en esta subred no tendrán direcciones IP públicas automáticamente.

Atributos Principales

vpc_id: Especifica el ID de la VPC donde se creará la subred. En este caso, se utiliza el ID de la VPC creada anteriormente (aws_vpc.red_global_allacare.id).
cidr_block: Especifica el rango de direcciones IP para la subred. En este caso, el bloque CIDR es "10.0.2.0/24".
availability_zone: Especifica la zona de disponibilidad donde se creará la subred. Aquí se ha seleccionado "us-east-1a".
tags: Etiquetas para identificar la subred. Aquí se ha añadido una etiqueta con el nombre "privada_allcare".
Esta configuración crea una VPC con un bloque CIDR de 10.0.0.0/16, y dentro de esta VPC se crean dos subredes en la zona de disponibilidad us-east-1a. La primera subred (publico_allacare) es pública y asignará direcciones IP públicas automáticamente a las instancias lanzadas en ella. La segunda subred (privada_allacare) es privada y no asignará direcciones IP públicas automáticamente. Esto proporciona una estructura básica de red que puede ser utilizada para desplegar aplicaciones con diferentes niveles de accesibilidad y seguridad.
 */
