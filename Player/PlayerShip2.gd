extends RigidBody2D

export var MAX_SPEED : = 10.0
export var MAX_TURN_SPEED : = 10.0

var direction : Vector2
var turn : float

func _physics_process(delta):
	
	direction = Vector2.ZERO
	turn = 0
	if Input.is_action_pressed("forword"):
		direction.y = -1
	if Input.is_action_pressed("backword"):
		direction.y = 1
	if Input.is_action_pressed("left"):
		turn = -1
	if Input.is_action_pressed("right"):
		turn = 1
		
#	if linear_velocity.length() < 10 and linear_velocity.length() > -10 :
	direction = direction.rotated(rotation)
	direction *= MAX_SPEED
	apply_impulse(Vector2.ZERO, direction)
	
#	if angular_velocity < 10 and angular_velocity > -10:
	turn *= MAX_TURN_SPEED
	apply_torque_impulse(turn)
	
