extends Area2D
#bullet

export var spark = preload("res://scenes/BulletSpark.tscn")
#var spark = preload("res://scenes/Bombsparkotion.tscn")

var vector = Vector2(0,0)

export var BULLET_SPEED = 25

func _ready():
	$Particles2D.emitting = true
	vector = Vector2(0, -BULLET_SPEED)
	vector = vector.rotated(rotation)

func _process(delta):
	
	var vec_d = vector * (delta * 60)
	position += vec_d
	
func _on_bullet_body_entered(body):
	if body.is_in_group("wall"):
		queue_free()
		var e = spark.instance()
		e.global_position = self.global_position
		e.rotation = self.rotation + PI / 2
		get_parent().add_child(e)
		
	elif body.is_in_group("enemy"):
#		yield(get_tree(), "idle_frame")
#		yield(get_tree(), "idle_frame")
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass
