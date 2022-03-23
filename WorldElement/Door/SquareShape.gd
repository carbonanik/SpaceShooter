tool
extends CollisionShape2D

export (Color) var inner_color := Color() setget set_inner_color

func _draw():
	var vec = shape.extents
	var rect = Rect2(position - vec, vec*2)
	draw_rect(rect, inner_color)

func set_inner_color(val: Color):
	inner_color = val
	update()
