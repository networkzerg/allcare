# config para crear el EC2
resource "aws_launch_configuration" "server_web_allcare" {
  name          = "server_web_allcare"
  image_id      = "ami-04b70fa74e45c3917"  # Aquí iría una AMI con características de seguridad a nivel de OS para albergar AllCare. Ahora mismo está seleccionada la ami de Canonical, Ubuntu, 24.04 LTS: ami-04b70fa74e45c3917
  instance_type = "t3.xlarge"
  security_groups = [aws_security_group.sg_web_allcare.id]

  lifecycle {
    create_before_destroy = true
  }
}

#Creación del grupo de autoescalado del que formará parte la instancia EC2: server_web_allcare

resource "aws_autoscaling_group" "grupo_de_autoescalado_allcare" {
  desired_capacity     = 1
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = ["subnet-02f3bdcf702b0326a"]
  launch_configuration = aws_launch_configuration.server_web_allcare.id
  health_check_type    = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "servidor_web_allcare"
    propagate_at_launch = true
  }
}

# políticas para definir como se debe comportar el grupo de autoescalado

resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale_out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.grupo_de_autoescalado_allcare.name
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale_in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.grupo_de_autoescalado_allcare.name
}

/*

Políticas de Escalado Automático
AWS Auto Scaling usa políticas para definir cuándo y cómo escalar las instancias EC2 en un grupo de autoescalado. Las dos políticas que tienes en el código son scale_out (para aumentar la capacidad) y scale_in (para reducir la capacidad).

aws_autoscaling_policy "scale_out"

Esta política se utiliza para incrementar el número de instancias en el grupo de autoescalado cuando se cumple una condición específica (generalmente relacionada con el uso de recursos, como CPU o memoria).

resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale_out"  # Nombre de la política
  scaling_adjustment     = 1            # Incremento en la cantidad de instancias
  adjustment_type        = "ChangeInCapacity"  # Tipo de ajuste: cambiar la capacidad en un número específico
  cooldown               = 300          # Período de enfriamiento en segundos
  autoscaling_group_name = aws_autoscaling_group.web_asg.name  # Nombre del grupo de autoescalado al que se aplica esta política
}

name: Nombre de la política de autoescalado.
scaling_adjustment: Número de instancias por el cual incrementar la capacidad. En este caso, se incrementa en 1.
adjustment_type: Tipo de ajuste. "ChangeInCapacity" significa que se cambia la capacidad total en una cantidad específica.
cooldown: Período de enfriamiento en segundos. Este es el tiempo que espera el grupo de autoescalado antes de realizar otro ajuste, permitiendo que el sistema se estabilice después del escalado.
autoscaling_group_name: Especifica el grupo de autoescalado al cual esta política se aplica.
aws_autoscaling_policy "scale_in"

Esta política se utiliza para disminuir el número de instancias en el grupo de autoescalado cuando se cumple una condición específica.

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale_in"   # Nombre de la política
  scaling_adjustment     = -1           # Decremento en la cantidad de instancias
  adjustment_type        = "ChangeInCapacity"  # Tipo de ajuste: cambiar la capacidad en un número específico
  cooldown               = 300          # Período de enfriamiento en segundos
  autoscaling_group_name = aws_autoscaling_group.web_asg.name  # Nombre del grupo de autoescalado al que se aplica esta política
}
name: Nombre de la política de autoescalado.
scaling_adjustment: Número de instancias por el cual reducir la capacidad. En este caso, se reduce en 1.
adjustment_type: Tipo de ajuste. "ChangeInCapacity" significa que se cambia la capacidad total en una cantidad específica.
cooldown: Período de enfriamiento en segundos. Este es el tiempo que espera el grupo de autoescalado antes de realizar otro ajuste, permitiendo que el sistema se estabilice después del escalado.
autoscaling_group_name: Especifica el grupo de autoescalado al cual esta política se aplica.
 */