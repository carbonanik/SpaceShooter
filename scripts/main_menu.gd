extends Control

var level_1 = preload("res://scenes/level_1.tscn")

func _ready():
	var viewport_rect_size = get_viewport_rect().size
	
	$ColorRect.rect_size = viewport_rect_size
	$ColorRect/Label.rect_size = viewport_rect_size
	$AnimationPlayer.play("compani_name_slide")
	$button_mid.rect_position.x = viewport_rect_size.x/2
	$button_mid.rect_position.y = viewport_rect_size.y/5
	$button_mid/button_cont.rect_position.x = - viewport_rect_size.x/2 - 125
	

func _on_AnimationPlayer_animation_finished(anim):
	if anim == "compani_name_slide":
		$AnimationPlayer.play("button_slide")


func _on_play_pressed():
	if $button_mid/button_cont/play.pressed == true:
		var l = level_1.instance()
		add_child(l)
		$button_mid.hide()
		$ColorRect.hide()
