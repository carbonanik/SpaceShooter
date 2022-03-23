extends KinematicBody2D
#player

var bullet = preload("res://scenes/bullet.tscn")
var lightning_strike = preload("res://Weapon/LightningStrike.tscn")

onready var fire_rate_timer = $FireRateTimer
onready var bullet_start_position = $BulletStartPosition
onready var bullet_container = $BulletStartPosition/BulletContainer
onready var smoke = $smoke
onready var energy_bar = $CanvasLayer/EnergyBar
onready var screen_overlay = $CanvasLayer/ColorRect
onready var screen_overlay_material = screen_overlay.material

export var turn_speed: = 4.0
export var speed: = 400.0
export var energy: = 100.0
export var super_hot_mode: = false
export var gun_type: = 1

var screen_size : Vector2
var velocity: = Vector2(0,0)
var direction: = Vector2(0,0)
var turn: = 0.0
var turn_li: = 0.0

func _ready():
	screen_size = get_viewport_rect().size
	get_viewport().connect("size_changed", self,"_on_screen_resized")
	energy_bar.value = energy
	Game.camera = $player_camera
	Game.tween = $tween

func _process(delta):
	
	direction = Vector2(0,0)
	turn = 0
	
	if Input.is_action_pressed("forword"):
		direction.y = -1
	if Input.is_action_pressed("backword"):
		direction.y = 1
	if Input.is_action_pressed("left"):
		turn = -1
	if Input.is_action_pressed("right"):
		turn = 1
		
	if Input.is_action_pressed("ui_accept"):
		fire()
	
	if Input.is_action_just_pressed("power_q"):
		if $LightningStater.get_child_count() == 0:
			var lightning_strike_instance = lightning_strike.instance()
			$LightningStater.add_child(lightning_strike_instance)
	
	if direction.y == 0 and super_hot_mode:
		Engine.time_scale = 0.1
	else:
		Engine.time_scale = 1.0
	
	turn_li = lerp(turn_li, turn, 0.2) 
	rotation = rotation + turn_li * delta * turn_speed * (1/Engine.time_scale)

	direction = direction.rotated(rotation) 
	
	velocity = velocity.linear_interpolate(direction * speed, 0.05)
	velocity = move_and_slide(velocity) 
	
	
	if velocity.length() > 0.3:
		smoke.set_emitting(true)
	else:
		smoke.set_emitting(false)


func fire():
	if fire_rate_timer.get_time_left() == 0 and energy > 0:
#		$FireFX.play()
		$muzzel_flash.show()
		color_distorsion()
		var b = bullet.instance()
		b.global_transform = bullet_start_position.global_transform
		bullet_container.add_child(b)
		fire_rate_timer.start()
		$FlashTimer.start()
		reduce_energy(1)


func die():
	print("Game Over")
#	queue_free()


func hurt_color_change():
	modulate = Color.red
	$ColorModulateTimer.start(0.1)


func _on_ColorModulateTimer_timeout():
	modulate = Color.white


func _on_player_damage_area_area_entered(area):
	if area.is_in_group("enemy_bullet"):
		reduce_energy(5)
		var agp = area.global_position
		hit_impuct(agp)
	if area.is_in_group("enemy"):
#		var damage_amount : float = body.damage_amount
		reduce_energy(20)


func hit_impuct(agp):
	var cpos = global_position - agp
	position += cpos


func _on_player_life_value_changed(value):
	if value <= 0:
		die()


func _on_FlashTimer_timeout():
	$muzzel_flash.hide()


func _on_screen_resized():
	screen_overlay_material.set_shader_param("resulation", get_viewport_rect().size)


func color_distorsion():
	screen_overlay_material.set_shader_param("offset", Vector2(0.005, 0.005))
	screen_overlay_material.set_shader_param("effect", 2)
	if !$EffectTimer.is_connected("timeout", self, "_color_distorsion_timeout"):
		$EffectTimer.connect("timeout", self, "_color_distorsion_timeout")
	$EffectTimer.start(0.05)


func _color_distorsion_timeout():
	screen_overlay_material.set_shader_param("offset", Vector2(0.0, 0.0))	
	screen_overlay_material.set_shader_param("effect", 0)


func add_energy(energy_plus):
	if energy < 100:
		energy += energy_plus
		if energy > 100:
			energy = 100
		energy_bar.value = energy


func reduce_energy(energy_minus):
	if energy > 0:
		energy -= energy_minus
		if energy < 0:
			energy = 0
		energy_bar.value = energy


func froze():
	modulate = Color("#28C7FA")
