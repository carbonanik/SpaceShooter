extends StaticBody2D
#fixed canon

var bullet    = preload("res://scenes/bullet_red.tscn")
var explotion = preload("res://scenes/BombExplotion.tscn")


onready var bullet_timer    = $FireRateTimer
onready var bullet_point    = $head_rotetor/BulletPosition
onready var bullet_container= $head_rotetor/BulletPosition/BulletContainer
onready var target          = get_node(target_path)
onready var head_rotetor    = $head_rotetor

export var target_path : = NodePath()
export var damage_amount: = 50.0


func _process(delta):
	rotate_head()

func rotate_head():
	var head_global_position = head_rotetor.global_position
	var target_global_position = target.global_position
	head_rotetor.rotation = (head_global_position - target_global_position).angle()

func check_fire_time():
	if bullet_timer.get_time_left() == 0:
		fire()

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.global_transform = bullet_point.global_transform
	bullet_container.add_child(bullet_instance)
	bullet_timer.start()


func explode_and_die():
	set_process(false)
	var explotion_isntance = explotion.instance()
	explotion_isntance.position = head_rotetor.position
	add_child(explotion_isntance)
	head_rotetor.queue_free()

func _on_HitArea_area_entered(area):
	if area.is_in_group("player_bullet"):
		explode_and_die()


func _on_FireRateTimer_timeout():
	fire()
