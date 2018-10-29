extends Area2D
#enemy

var bullet = preload("res://scenes/bullet.tscn")

onready var bullet_timer = $bullet_timer
onready var bullet_pos = $bullet_pos
onready var condencer = $bullet_pos/condencer

var life_left = 100

#seek
var velocity = Vector2()
var desired_velocity = Vector2()
var target = Vector2()
var steering = Vector2()
var mass = 100
var max_velocity = 2
var max_speed = 2
var max_force = 2
#arrival
var distance
var slowingRadius = 200


func _ready():
	#velocity = (target - position).normalized() * max_velocity
	pass

func _process(delta):
	randomize()
	var random_targate = randi() % 5
	print(random_targate)
	target = game_main.player_pos
	
	desired_velocity = target - position
	distance = (desired_velocity).length()
	
	if distance < slowingRadius:
		desired_velocity = (target - position).normalized() * max_velocity * (distance / slowingRadius)
	else:
		desired_velocity = (target - position).normalized() * max_velocity
		
	steering = desired_velocity - velocity
	steering = steering.clamped(max_force)
	#print(steering.length())
	
	steering /= mass
	velocity = (velocity + steering)#.clamped(max_speed)
	if velocity.dot(desired_velocity) > 2.5:
		fire()
	
	rotation = velocity.angle() + PI/2
	position += velocity
	
	$life_c.rotation = -rotation

func fire():
	if bullet_timer.get_time_left() == 0:
		var b = bullet.instance()
		b.global_transform = bullet_pos.global_transform
		condencer.add_child(b)
		bullet_timer.start()


func _on_rocket3_body_entered(body):
	$Sprite.modulate = ColorN("red")
	
func _on_rocket3_body_exited(body):
	$Sprite.modulate = ColorN("white")


func _on_rocket3_area_entered(area):
	if area.is_in_group("bullet"):
		life_left -= 5
		$life_c/life.value = life_left
		if life_left < 1:
			explore()


func explore():
	$CollisionShape2D.disabled = true
	set_process(false)
	$Sprite.hide()
	$life_c.hide()
	$animation.play("exp")