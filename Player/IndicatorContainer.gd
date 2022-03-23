extends Node2D

var enemy_indicator = preload("res://Player/EnemyIndicator.tscn")


func _on_EnemySensor_body_entered(body):
	if body.is_in_group("enemy"):
		var ei = enemy_indicator.instance()
		ei.target_ = body
		ei.name = body.name
		add_child(ei)


func _on_EnemySensor_body_exited(body):
	if body.is_in_group("enemy"):
		if has_node(body.name):
			get_node(body.name).queue_free()
			


func _on_EnemyDeSensor_body_exited(body):
	if body.is_in_group("enemy"):
		if has_node(body.name):
			var sensor = get_node(body.name)
			sensor.activate()
		


func _on_EnemyDeSensor_body_entered(body):
	if body.is_in_group("enemy"):
		if has_node(body.name):
			var sensor = get_node(body.name)
			sensor.deactivate()
