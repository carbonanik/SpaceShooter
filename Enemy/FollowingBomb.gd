extends KinematicBody2D
#FlottingBomb

var explotion = preload("res://scenes/BombExplotion.tscn")
var energy_pack = preload("res://WorldElement/EnergyPack.tscn")

export var damage_amount : = 10.0
export var time_scale: = 1.0
export var wondering_distance: = 10.0

export var max_speed : = 180.0
export var mass : = 30.0
export var target_path : = NodePath()

enum States { WONDERING, FOLLOWING }
var current_state = States.WONDERING
var frozen : = false

onready var target = get_node(target_path)


var _velocity: = Vector2.ZERO
var target_global_position : Vector2

func _ready():
	set_process(false)


func _process(delta):
		
	target_global_position = target.global_position
	
	_velocity = steering.follow(
		_velocity,
		global_position,
		target_global_position,
		max_speed * time_scale,
		mass
	)
	
	_velocity = move_and_slide(_velocity)
	

func _on_SenceArea_body_entered(body):
	if(body.is_in_group("player")):
		set_process(true)


#func _on_BlastArea_body_entered(body):
#	if(body.is_in_group("player")):
#		blast()


func blast():
	var explotion_instance = explotion.instance()
	explotion_instance.global_position = global_position
#	explotion_instance.time_scale = time_scale
	get_parent().add_child(explotion_instance)
#	ScreenShake.screen_shake(0.5 * time_scale, 20, 10)
	leave_energy()
	queue_free()

func init_balst():
	var explotion_instance = explotion.instance()
	explotion_instance.global_position = global_position
#	explotion_instance.time_scale = time_scale
	get_parent().add_child(explotion_instance)
#	ScreenShake.screen_shake(0.5 * time_scale, 20, 10)
	queue_free()


func leave_energy():
	var e = energy_pack.instance()
	e.global_position = global_position
	e.time_scale = time_scale
	get_parent().add_child(e)


func _on_BlastArea_area_entered(area):
	if area.is_in_group("player_bullet"):
		blast()
	if area.is_in_group("player"):
		blast()

func change_state():
	match current_state:
		States.WONDERING:
			pass
		States.FOLLOWING:
			pass

func froze():
	frozen = true
	$CircleShape.inner_color = Color("#28C7FA")
#	set_physics_process(false)
#	set_process(false)
