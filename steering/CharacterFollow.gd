extends KinematicBody2D


onready var sprite: Sprite = $body
onready var target: = get_node(target_path)

const ARRIVE_THRESHOLD: = 3.0
const SLOW_RADIUS: = 200.0

export var max_speed: = 200.0
export var target_path: = NodePath()
export var follow_offset: = 100.0

var _velocity: = Vector2.ZERO

func _physics_process(delta):
	if target == self:
		set_physics_process(false)
	
	var target_global_position : Vector2 = target.global_position
#	var terget_with_follow_offset : Vector2 
	
	var to_target: = global_position.distance_to(target_global_position)
	
	if to_target < ARRIVE_THRESHOLD:
		return
		
	var follow_global_position: Vector2
	
	_velocity = steering.arrive_to(
		_velocity,
		global_position,
		target_global_position,
		max_speed
	)
	
	_velocity = move_and_slide(_velocity)
	sprite.rotation = _velocity.angle() - deg2rad(-90)
