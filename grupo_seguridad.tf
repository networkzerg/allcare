resource "aws_security_group" "sg_web_allcare" {
  vpc_id = "vpc-0113972d42e644741"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_web_allcare"
  }
}
 /*
Recurso: aws_security_group "sg_web_allcare"
Este recurso define un grupo de seguridad (Security Group) en AWS, que controla el tráfico de red permitido hacia y desde las instancias asociadas en una VPC específica.

Atributos Principales

vpc_id: Especifica el ID de la VPC donde se crea el grupo de seguridad. En este caso, el ID es "vpc-0113972d42e644741".
Reglas de Ingreso (Ingress Rules)

Estas reglas controlan el tráfico entrante permitido hacia las instancias asociadas al grupo de seguridad.

Regla 1:

from_port: Puerto de inicio del rango permitido, configurado en 80.
to_port: Puerto final del rango permitido, configurado en 80.
protocol: Protocolo de red permitido, configurado en "tcp".
cidr_blocks: Rango de direcciones IP permitidas, configurado en "0.0.0.0/0" (permite tráfico desde cualquier IP).
Regla 2:

from_port: Puerto de inicio del rango permitido, configurado en 443.
to_port: Puerto final del rango permitido, configurado en 443.
protocol: Protocolo de red permitido, configurado en "tcp".
cidr_blocks: Rango de direcciones IP permitidas, configurado en "0.0.0.0/0" (permite tráfico desde cualquier IP).
Reglas de Egreso (Egress Rules)

Estas reglas controlan el tráfico saliente permitido desde las instancias asociadas al grupo de seguridad.

Regla única:
from_port: Puerto de inicio del rango permitido, configurado en 0.
to_port: Puerto final del rango permitido, configurado en 0.
protocol: Protocolo de red permitido, configurado en "-1" (permite cualquier protocolo).
cidr_blocks: Rango de direcciones IP permitidas, configurado en "0.0.0.0/0" (permite tráfico hacia cualquier IP).
Etiquetas (Tags)

tags: Etiquetas para identificar el grupo de seguridad. Aquí se ha añadido una etiqueta con el nombre "sg_web_allcare".
Esta configuración del grupo de seguridad permite el tráfico HTTP (puerto 80) y HTTPS (puerto 443) entrante desde cualquier dirección IP, y permite todo el tráfico saliente desde las instancias asociadas. Esto es ideal para una aplicación web accesible públicamente que necesita responder a solicitudes HTTP y HTTPS.
 */