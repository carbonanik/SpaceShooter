extends Area2D
#enemy


#seek
var velocity = Vector2()
var desired_velocity = Vector2()
var steering = Vector2()
var mass = 20
var max_velocity = 10
var max_speed = 5
var max_force = 1
#arrival
var distance
var slowingRadius = 400
var stopRadius = 200


var tar = Vector2()


func _ready():
	#velocity = (target - global_position).normalized() * max_velocity
	pass



func _process(delta):
	random_targrt()
	
	steering = seek(tar)
	steering = steering.clamped(max_force)
	
	steering /= mass
	velocity = (velocity + steering).clamped(max_speed)
	
	global_rotation = velocity.angle() + PI/2
	global_position += velocity


func  seek(target):
	desired_velocity = target - global_position
	desired_velocity = (target - global_position).normalized() * max_velocity 
	desired_velocity = (target - position).normalized() * max_velocity
	steering = desired_velocity - velocity
	return steering

func flee(target):
	desired_velocity = global_position - target
	desired_velocity = (target - global_position).normalized() * max_velocity 
	desired_velocity = (target - position).normalized() * max_velocity
	steering = desired_velocity - velocity
	return steering

func random_targrt():
	pass
	
	
func arrival(target):
	pass

func wander():
	pass


func _on_rocket3_area_entered(area):
	if area.is_in_group("bullet"):
		explore()



func explore():
	queue_free()
	pass


func _on_Area2D_area_entered(area):
	randomize()
	var r = randi()%5 
	var t = get_parent().get_child(r)
	#if t != null:
	tar =  t.position
