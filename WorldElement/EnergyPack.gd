extends Area2D

export var energy:= 10
export var gradient: Gradient 
export var time_scale: = 1.0

func _on_EnergyPack_body_entered(body):
	if body.is_in_group("player"):
		body.add_energy(energy)
		$Particles2D.speed_scale = time_scale
#		$Particles2D.lifetime = ($Particles2D.lifetime / time_scale)
		print($Particles2D.lifetime)
		$AnimationPlayer.play("energy_collected")

func set_g():
	pass
