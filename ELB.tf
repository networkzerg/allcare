resource "aws_elb" "webserver_elb" {
  name = "ELBallcare"

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "webserver_elb"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.grupo_de_autoescalado_allcare.name
  elb                    = aws_elb.webserver_elb.name
}

/*
Recurso: aws_elb "webserver_elb"
Este recurso define un Elastic Load Balancer (ELB) en AWS para distribuir el tráfico HTTP a las instancias de la aplicación web.

Atributos Principales

name: Define el nombre del ELB, en este caso, "ELBallcare".

availability_zones: Especifica las zonas de disponibilidad donde se desplegará el ELB. Aquí se han seleccionado las zonas "us-east-1a" y "us-east-1b".

Configuración del Listener

El listener es responsable de escuchar las solicitudes entrantes y dirigirlas a las instancias backend.

instance_port: El puerto en la instancia al cual se dirige el tráfico, configurado en 80.
instance_protocol: El protocolo usado en la instancia, configurado como "HTTP".
lb_port: El puerto del Load Balancer en el cual se escucharán las solicitudes, configurado en 80.
lb_protocol: El protocolo usado por el Load Balancer, configurado como "HTTP".
Configuración del Health Check

El Health Check se utiliza para verificar la salud de las instancias backend.

target: El destino de la verificación de salud, configurado en "HTTP:80/".
interval: El intervalo en segundos entre cada verificación, configurado en 30 segundos.
timeout: El tiempo de espera en segundos para cada verificación, configurado en 5 segundos.
healthy_threshold: El número de verificaciones exitosas necesarias para considerar una instancia como saludable, configurado en 2.
unhealthy_threshold: El número de verificaciones fallidas necesarias para considerar una instancia como no saludable, configurado en 2.
Etiquetas (Tags)

tags: Etiquetas para identificar el ELB. Aquí se ha añadido una etiqueta con el nombre "webserver_elb".
Recurso: aws_autoscaling_attachment "asg_attachment"
Este recurso conecta el grupo de autoescalado (Auto Scaling Group) con el ELB, permitiendo que las instancias en el grupo de autoescalado se registren automáticamente en el ELB.

Atributos Principales

autoscaling_group_name: El nombre del grupo de autoescalado al cual se va a adjuntar el ELB. Este nombre se obtiene del recurso aws_autoscaling_group con el nombre grupo_de_autoescalado_allcare.
elb: El nombre del ELB al cual se adjuntará el grupo de autoescalado. Este nombre se obtiene del recurso aws_elb con el nombre webserver_elb.
Esta configuración asegura que el tráfico HTTP dirigido a tu aplicación web sea distribuido de manera eficiente entre las instancias en dos zonas de disponibilidad, además de garantizar que solo las instancias saludables reciban tráfico.
*/