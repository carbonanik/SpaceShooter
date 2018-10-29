extends Node2D


var enemy_1 = preload("res://scenes/enemy_1.tscn")
var is_sut_lock = true
#func _ready():
	


func _on_1_body_entered(body):
	if body.is_in_group("player") == true:
		var e_1 = enemy_1.instance()
		$enemys_cont/one.add_child(e_1)


func _on_shutter_opner_body_entered(body):
	if body.is_in_group("player") and !is_sut_lock:
		$AnimationPlayer.play("shutter_1_open")


func _on_shutter_opner_body_exited(body) :
	if body.is_in_group("player") and !is_sut_lock:
		$AnimationPlayer.play("shutter_1_close")

func _on_Area2D_area_entered(area):
	is_sut_lock = false