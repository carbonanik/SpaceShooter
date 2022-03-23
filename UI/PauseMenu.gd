extends CanvasLayer



func _on_Pause_pressed():
	$PauseMenuContainer/ButtonMid.show()
	$PauseMenuContainer/ButtonRight.hide()
	$PauseMenuContainer/ColorRect.show()
	Game.pause_current_level()


func _on_Resume_pressed():
	$PauseMenuContainer/ButtonMid.hide()
	$PauseMenuContainer/ButtonRight.show()
	$PauseMenuContainer/ColorRect.hide()
	Game.resume()


func _on_MainMenu_pressed():
	Game.open_main_menu()
	pass


func _on_Restart_pressed():
	Game.restart_level()
