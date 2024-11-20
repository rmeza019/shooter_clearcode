extends Area2D

var rotation_speed:int = 5
var item_types = ["laser", "laser", "grenade", "health"]
var type = item_types[randi() % len(item_types)]

func _ready() -> void:
	if type == "laser":
		$Sprite2D.modulate = Color(0, 0, 0.7, 1)
	elif type == "grenade":
		$Sprite2D.modulate = Color(0.7, 0, 0, 1)
	else:
		$Sprite2D.modulate = Color(0, 0.7, 0, 1)

func _process(delta: float) -> void:
	rotation += rotation_speed * delta

func _on_body_entered(_body: Node2D) -> void:
	if type == "laser":
		Globals.laser_amount += 5
	elif type == "grenade":
		Globals.grenade_amount += 1
	elif type == "health":
		Globals.health += 15
	queue_free()
