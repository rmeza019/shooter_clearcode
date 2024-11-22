extends StaticBody2D
class_name ItemContainer

signal spawn_item(position, direction)

@onready var current_direction:Vector2 = Vector2.DOWN.rotated(rotation)
var opened:bool = false
