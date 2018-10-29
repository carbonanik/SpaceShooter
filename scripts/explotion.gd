extends Particles2D


func _on_Particles2D_tree_entered():
	emitting = true


func _on_Timer_timeout():
	queue_free()
