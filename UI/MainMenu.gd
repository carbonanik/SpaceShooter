extends Control
#######   main menu

enum which_menu {MAIN, PAUSE, ONGAME}
var active_menu : = true
#signal cont 

func _ready():
	print_debug("main menu")

func _on_play_pressed():
	print_debug("play_pressed")
	Game.next_level()
#	print_debug(SceneDictionary.levels[1])
#	var level : = load(SceneDictionary.levels[1])
#	var instanched_level = level.instance()
#	instanched_level.pause_mode = PAUSE_MODE_PROCESS
#	add_child(instanched_level)
#	get_tree().paused = true
	pass
