extends Node2D

export var explotion = preload("res://scenes/BombExplotion.tscn")
export var energy_pack = preload("res://WorldElement/EnergyPack.tscn")
var canon_bullet = preload("res://scenes/bullet_red.tscn")


func _ready():
	var ex = explotion.instance()
	var ep = energy_pack.instance()
	var cb = canon_bullet.instance()
	
	
	add_child(ex)
	add_child(ep)
	add_child(cb)
	
#	remove_child(ex)
#	remove_child(ep)
#	remove_child(cb)
