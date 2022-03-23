extends KinematicBody2D

onready var sprite: Sprite = $Sprite

export var max_speed = 500.0
var _velocity: = Vector2.ZERO

func _physics_process(delta):
	var terget_glaobal_position: Vector2 = get_global_mouse_position()
	
	_velocity = Vector2()
	move_and_slide(_velocity)
