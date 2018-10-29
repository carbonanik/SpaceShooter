extends Area2D

var vector = Vector2(0,0)

var BULLET_SPEED = 7

func _process(delta):
	vector = Vector2(0,-BULLET_SPEED)
	vector = vector.rotated(rotation)
	position += vector
	if $timer.get_time_left() == 0:
		queue_free()