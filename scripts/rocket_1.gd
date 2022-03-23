extends RigidBody2D

var velocity = Vector2()
var direction = 0.0
var bullet = preload("res://scenes/bullet.tscn")
var b

onready var bullet_timer = get_node("bullet_timer")
onready var bullet_pos = get_node("bullet_pos")
onready var condencer = get_node("bullet_pos/condencer")
onready var smoke = $smoke

var clamped_lv

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	position = screen_size / 2
	
func _process(delta):
	game_main.player_pos = position
	velocity = Vector2()
	direction = 0
	if Input.is_action_pressed("ui_up"):
		velocity.y = -5
	if Input.is_action_pressed("ui_down"):
		velocity.y = 5
	if Input.is_action_pressed("ui_left"):
		direction = -5000
	if Input.is_action_pressed("ui_right"):
		direction = 5000
	if Input.is_action_pressed("ui_accept"):
		fire()
		
	
	velocity = velocity.rotated(rotation)
	apply_impulse(Vector2(0,0),velocity)
	
	clamped_lv = linear_velocity.clamped(200)
	set_applied_torque(direction)
	
	
	if linear_velocity.length() > 200.0:
		set_linear_velocity(clamped_lv)
	
	if linear_velocity.length() > 1:
		smoke.set_emitting(true)
	else:
		smoke.set_emitting(false)
	
func fire():
	if bullet_timer.get_time_left() == 0:
		b = bullet.instance()
		b.global_transform = bullet_pos.global_transform
		condencer.add_child(b)
		bullet_timer.start()
	
	
