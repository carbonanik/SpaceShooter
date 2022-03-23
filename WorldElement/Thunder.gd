extends Node2D


export var min_segment_size_big : int = 50
export var thunder_width_big : int = 100
export var line_width_big : int = 3
export (Color) var thunder_color_big : Color = Color("#FFB7A6")

export var min_segment_size_small : int = 20
export var thunder_width_small : int = 40
export var line_width_small : int = 1
export (Color) var thunder_color_small : Color = Color("#FF876B")

export var target_path : NodePath
onready var target = get_node(target_path)
onready var line_wide = $Node/ThunderLineBig
onready var line_thin_1 = $Node/ThunderLineSmall1
onready var line_thin_2 = $Node/ThunderLineSmall2

var start_point : Vector2 = Vector2.ZERO
var end_point : Vector2   = Vector2.ZERO


func _ready():
	randomize()
	line_wide.width = line_width_big
	line_wide.default_color = thunder_color_big
	
	line_thin_1.width = line_width_small
	line_thin_1.default_color = thunder_color_small
	
	line_thin_2.width = line_width_small
	line_thin_2.default_color = thunder_color_small


func thunder_flash(var min_segment_size : int, var thunder_width : int):
	var thunder_points : PoolVector2Array
	var thunder_line : Vector2 =  end_point - start_point
	var thunder_length : float = thunder_line.length()
	var thunder_direction : Vector2 = thunder_line.normalized()
	
	var previous_point : Vector2 = start_point
	var segment_count : int = thunder_length / min_segment_size
	var segment_length : float 
	if segment_count != 0:
		segment_length = thunder_length / segment_count
	
	for i in segment_count:
		if i == 0:
			thunder_points.append(start_point)
			continue
		
		var point = previous_point + thunder_direction * segment_length
		previous_point = point
		point += thunder_direction.rotated(PI/2) * (randi() % thunder_width - thunder_width/2)
		thunder_points.append(point)
		
	thunder_points.append(end_point)
	$EnemyBlastTimer.start()
	return thunder_points

func blast_enemy():
	if target.is_in_group("enemy"):
		target.blast()


func clear():
	var ps : PoolVector2Array 
	ps.append(Vector2.ZERO)
	line_wide.points = ps
	line_thin_1.points = ps
	line_thin_2.points = ps
	

func set_start_end_point():
	start_point = target.global_position
	end_point = global_position

func _on_Timer_timeout():
	clear()
	if target != null:
		set_start_end_point()
		line_wide.points = thunder_flash(min_segment_size_big, thunder_width_big)
		line_thin_1.points = thunder_flash(min_segment_size_small, thunder_width_small)
		line_thin_2.points = thunder_flash(min_segment_size_small, thunder_width_small)


func _on_SenceArea_body_entered(body):
	if body.is_in_group("enemy"):
		target = body
		$Timer.start()
		
	if body.is_in_group("player"):
		$Timer.start()


func _on_SenceArea_body_exited(body):
	if body.is_in_group("player"):
		$Timer.stop()
		clear()


func deactivate():
	$Timer.stop()
	$SenceArea/CollisionShape2D.disabled = true

func activate():
	$SenceArea/CollisionShape2D.disabled = false


func _on_EnemyBlastTimer_timeout():
	blast_enemy()
