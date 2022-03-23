extends Node2D


var is_sut_lock = true

func _on_Area2D_area_entered(area):
	is_sut_lock = false

