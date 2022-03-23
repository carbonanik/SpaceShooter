extends Area2D



func _on_LevelChange_body_entered(body):
	if body.is_in_group("player"):
		Game.next_level()
		#level ended
		pass
