extends Node

var point
var target

export(NodePath) var targetPath

export var trailLength1: = 20
export var trailLength2: = 10

export var width1 = 5
export var width2 = 10

export(Color) var color1 = Color.aqua
export(Color) var color2 = Color.purple

onready var line_one = $Line1
onready var line_two = $Line2

func _ready():
	target = get_node(targetPath)
	
	line_one.gradient.set_color(1, color1)
	line_one.width = width1
	
	line_two.gradient.set_color(1, color2)
	line_two.width = width2
	
	var ts = Engine.time_scale
	trailLength1 = trailLength1 * (1/ts)
	trailLength2 = trailLength2 * (1/ts)


func _process(delta):
	point = target.global_position
	
	line_one.add_point(point)
	if line_one.get_point_count() > trailLength1:
		line_one.remove_point(0)
	
	line_two.add_point(point)
	if line_two.get_point_count() > trailLength2:
		line_two.remove_point(0)
