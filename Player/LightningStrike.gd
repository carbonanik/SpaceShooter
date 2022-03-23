extends Node2D
# Lightning Stater

var lightning = preload("res://Player/Lightning.tscn")

onready var lightning_collision_shape = $StrikeZone/CollisionShape2D


func _on_StrikeZone_body_entered(body):
	if body.is_in_group("flotting_bomb"):
		var lightning_instance = lightning.instance()
		lightning_instance.target = body
		lightning_instance.name = body.name
		add_child(lightning_instance)


func _on_StrikeZone_body_exited(body):
	if body.is_in_group("flotting_bomb"):
		if has_node(body.name):
			var expired_lightning = get_node(body.name)
			expired_lightning.queue_free()


func _on_StrikeZoneLiveTime_timeout():
	queue_free()
