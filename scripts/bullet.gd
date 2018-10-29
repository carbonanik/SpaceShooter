extends Area2D

var expl = preload("res://scenes/explotion.tscn")
var vector = Vector2(0,0)

var BULLET_SPEED = 15

func _process(delta):
	vector = Vector2(0,-BULLET_SPEED)
	vector = vector.rotated(rotation)
	position += vector
	if $timer.get_time_left() == 0:
		queue_free()

func _on_bullet_body_entered(body):
	if body.is_in_group("wall"):
		var e = expl.instance()
		e.global_position = self.global_position
		get_parent().add_child(e)
		queue_free()