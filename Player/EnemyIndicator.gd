extends Position2D

var target_ = Node2D

func _physics_process(delta):
	if target_ != null:
		var target_global_position = target_.global_position
		global_rotation = (global_position - target_global_position).angle() - PI / 2


func deactivate():
	set_physics_process(false)
	$EnemyIndicatorSprite.visible = false

func activate():
	set_physics_process(true)
	$EnemyIndicatorSprite.visible = true
