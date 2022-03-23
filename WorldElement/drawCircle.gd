tool
extends CollisionShape2D

export (Color) var inner_color := Color() setget set_inner_color


func _draw() -> void:
	draw_circle(Vector2.ZERO, shape.radius, inner_color)

func set_inner_color(val: Color) -> void:
	inner_color = val
	update()
