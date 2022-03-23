extends Node2D
#screen_shakes
class ScreenShake:

	var current_shake_priority = 0

	func move_camera(vector : Vector2):
	#	get_node("/root/level/player/player_camera").offset = Vector2(rand_range(-vector.x, vector.x), rand_range(-vector.y, vector.y))
		game_main.camera.offset = Vector2(rand_range(-vector.x, vector.x), rand_range(-vector.y, vector.y))
	
		
	func shake(shake_length, shake_power, shake_priority):
		if shake_priority >= current_shake_priority:
			current_shake_priority = shake_priority
			var tween = game_main.tween
			tween.interpolate_method(self, "move_camera", Vector2(shake_power, shake_power), 
			Vector2(0,0), shake_length, Tween.TRANS_SINE, Tween.EASE_OUT, 0 )
	
			var t = tween.is_connected( "tween_completed", self, "_on_tween_completed" )
			if (!t):
				tween.connect( "tween_completed", self, "_on_tween_completed" )
			tween.start()
		pass
	
	func _on_tween_completed():
		current_shake_priority = 0
