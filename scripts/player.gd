extends KinematicBody2D
#player

var bullet = preload("res://scenes/bullet.tscn")

onready var bullet_timer = $bullet_timer
onready var bullet_pos = $bullet_pos
onready var condencer = $bullet_pos/condencer
onready var smoke = $smoke



var velocity = Vector2(0,0)
var direction = Vector2(0,0)
var turn = 0
var turn_li = 0
var MAX_TURN_SPEED = 4
var speed = 80

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	#position = screen_size / 2

func _process(delta):
	game_main.player_pos = global_position
	#$player_camera.position = game_main.player_pos
	direction = Vector2(0,0)
	turn = 0
	
	if Input.is_action_pressed("ui_up"):
		direction.y = -5
	if Input.is_action_pressed("ui_down"):
		direction.y = 5
	if Input.is_action_pressed("ui_left"):
		turn = -MAX_TURN_SPEED
	if Input.is_action_pressed("ui_right"):
		turn = MAX_TURN_SPEED
		
	if Input.is_action_pressed("ui_accept"):
		fire()
	
	
	turn_li = lerp(turn_li, turn, 0.2)
	rotation = rotation + turn_li*delta
	
	velocity = velocity.linear_interpolate(direction, 0.05)
	move_and_slide(velocity.rotated(rotation)*speed)
	
	
	if velocity.length() > 0.3:
		smoke.set_emitting(true)
	else:
		smoke.set_emitting(false)
	
	
	$CanvasLayer/player_life.value = game_main.player_life


func fire():
	if bullet_timer.get_time_left() == 0:
		var b = bullet.instance()
		b.global_transform = bullet_pos.global_transform
		condencer.add_child(b)
		bullet_timer.start()


func die():
	queue_free()


func _on_player_damage_area_area_entered(area):
	if area.is_in_group("enemy_bullet"):
		game_main.player_life -= 5


func _on_player_tree_exiting():
	game_main.game_over = true


func _on_player_life_value_changed(value):
	if value <= 0:
		die()
