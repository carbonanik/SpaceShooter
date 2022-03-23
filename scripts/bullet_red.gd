extends Area2D

var vector = Vector2(0,0)

export var BULLET_SPEED = 7

func _ready():
	vector = Vector2(0, -BULLET_SPEED)
	vector = vector.rotated(rotation)

func _process(delta):
	var vec_d = vector * (delta * 60)
	position += vec_d
	if $timer.get_time_left() == 0:
		queue_free()

func _on_bullet_red_body_entered(body):
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	queue_free()
