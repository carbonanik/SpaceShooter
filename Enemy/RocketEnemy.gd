extends KinematicBody2D
#RocketEnemy

var explotion = preload("res://scenes/BombExplotion.tscn")

export var damage_amount: = 10.0
export var time_scale: = 1.0

export var max_speed: = 800.0
export var mass: = 80.0
export var target_path: NodePath = "../../player"
export var frozen_factor: = 1.0

onready var target = get_node(target_path)


var _velocity: = Vector2.ZERO
var target_global_position : Vector2


func _process(delta):
	target_global_position = target.global_position
	
	_velocity = steering.follow(
		_velocity,
		global_position,
		target_global_position,
		max_speed * frozen_factor,
		mass
	)
	
	_velocity = move_and_slide(_velocity)
	rotation = _velocity.angle()


func blast():
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")

	var explotion_instance = explotion.instance()
	explotion_instance.global_position = global_position
	get_parent().add_child(explotion_instance)
	ScreenShake.screen_shake(1.5, 20, 10)
	queue_free()


func _on_DamageArea_body_entered(body):
	if body.is_in_group("player"):
		blast()


func _on_DamageArea_area_entered(area):
	pass # Replace with function body.
