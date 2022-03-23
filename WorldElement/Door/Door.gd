extends Node2D

var sutter_open : bool = false

func _on_sence_area_body_entered(body):
	if body.is_in_group("player") and !lock_working() and !sutter_open:
		sutter_open = true
		$animation.play("DoreOpen")

func _on_sence_area_body_exited(body):
	if body.is_in_group("player") and !lock_working() and sutter_open:
		sutter_open = false
		$animation.play("DoreClose")

func lock_working() -> bool:
	var l_w := false
	var s = get_parent().get_parent()
	if s.is_in_group("DoorSwitch"):
		l_w = s.lock_working
		
	return l_w
	
