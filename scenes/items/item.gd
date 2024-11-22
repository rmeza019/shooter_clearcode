extends Area2D

var rotation_speed:int = 5
var item_types = ["laser", "laser", "grenade", "health"]
var type = item_types[randi() % len(item_types)]
var direction:Vector2
var distance:int = randi_range(150, 250)

func _ready() -> void:
	if type == "laser":
		$Sprite2D.modulate = Color(0, 0, 0.7, 1)
	elif type == "grenade":
		$Sprite2D.modulate = Color(0.7, 0, 0, 1)
	else:
		$Sprite2D.modulate = Color(0, 0.7, 0, 1)
		
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).from(Vector2(0, 0))
	tween.tween_property(self, "position", target_pos, 0.5)

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
