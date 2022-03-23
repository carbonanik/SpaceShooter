extends Node

# Game

#var player_pos = Vector2(0,0)
var camera : Camera2D
var tween : Tween

#export var player_life = 100.0

#var game_over = false

var current_open_level : = 0
var last_unlocked_level : = 0
var last_played_level : = 0

func _ready():
	open_main_menu()
	pass

func open_main_menu():
	remove_previous_scene()
	var menu = SceneDictionary.manues["main"]
	current_open_level = 0	
	load_scene(menu)

func add_pause_menu():
	var menu = SceneDictionary.manues["pause"]
	load_scene(menu)

func pause_current_level():
	if current_open_level != 0:
		get_tree().paused = true
#		for child in get_children():
#			if child.name == "PauseMenu":
#				(child as Node).pause_mode = PAUSE_MODE_PROCESS
#				get_tree().paused = true

func resume():
	get_tree().paused = false

func remove_previous_scene():
	if get_child_count() != 0:
		for child in get_children():
			child.queue_free()

func next_level():
	last_played_level += 1
	current_open_level = last_played_level
	
	var level = SceneDictionary.levels[last_played_level]
	remove_previous_scene()
	load_scene(level)
	add_pause_menu()

func selected_level(level_numbe : int):
	var level = SceneDictionary.levels[level_numbe]
	remove_previous_scene()
	load_scene(level)
	add_pause_menu()

func load_scene(scene_path : String):
	var scene : Resource = load(scene_path)
	print_debug(scene)
	var instanched_scene : Node = scene.instance()
	add_child(instanched_scene)

func restart_level():
	if current_open_level != 0:
		for child in get_children():
			if (child as Node).name == "Level" + String(current_open_level):
				(child as Node).queue_free()
				load_scene("Level" + String(current_open_level))
