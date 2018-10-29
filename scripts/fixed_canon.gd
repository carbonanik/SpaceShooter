extends Node2D

var bullet = preload("res://scenes/bullet_red.tscn")
var expl = preload("res://scenes/explotion_2.tscn")


onready var bullet_timer = $bullet_timer
onready var bullet_pos = $head_pos/bul_pos
onready var condencer = $head_pos/bul_pos/condencer

var head_rot = 0
var pos
var p_pos

func _process(delta):
	$head_pos.rotation = head_rot
	pos = $head_pos.global_position
	p_pos = game_main.player_pos
	
	head_rot = (pos - p_pos).angle()
	
	if bullet_timer.get_time_left() == 0:
		var b = bullet.instance()
		b.global_transform = bullet_pos.global_transform
		condencer.add_child(b)
		bullet_timer.start()

func _on_body_area_entered(area):
	if area.is_in_group("bullet"):
		set_process(false)
		var e = expl.instance()
		e.position = $head_pos.position
		add_child(e)
		$head_pos/fixed_cannon_head.hide()
		$head_pos/nozzel.hide()