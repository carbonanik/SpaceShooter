extends Area2D

export var lock_working : bool = true

var lock_life : int = 5


func _on_DoorSwitch_area_entered(area):
	if lock_life > 0:
		lock_life -= 1
	if lock_life == 0:
		lock_damage()

func lock_damage():
	lock_working = false
	$SquareShape.inner_color = Color.rebeccapurple
