extends Node2D

onready var body_image : = $body

var exploded : = false
var will_explode : = false
var active : = false

func _on_FrozeCircle_area_entered(area):
	if area.is_in_group("frozeable") and active:
		area.froze()


func _on_FrozeCircle_body_entered(body):
	if body.is_in_group("frozeable") and active:
		body.froze()
	pass


func _on_SenceArea_body_entered(body):
	if body.is_in_group("player"):
		if !exploded:
			body_image.frame = 1
			$explode_timer.start()
			will_explode = true

func _on_SenceArea_body_exited(body):
	if body.is_in_group("player"):
		if !exploded:
			if body_image.frame == 1:
				body_image.frame = 0
				will_explode = false


func explode():
	active = true
	body_image.frame = 2
	exploded = true
	$AnimationPlayer.play("FrozeCircleGrow")
	$ActiveTimer.start()


func _on_explode_timer_timeout():
	if will_explode:
		explode()


func _on_ActiveTimer_timeout():
	active = false
