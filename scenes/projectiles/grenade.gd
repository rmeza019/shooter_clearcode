extends RigidBody2D

@export var speed:int = 750
var entity_in_attack_area:bool = false
var is_exploding:bool = false
var explosion_radius:int = 400

func explode() -> void:
	is_exploding = true
	$AnimationPlayer.play("Explosion")
	
func _process(_delta: float) -> void:
	if is_exploding:
		var targets = get_tree().get_nodes_in_group("Entities") + get_tree().get_nodes_in_group("Container")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if "hit" in target and in_range:
				target.hit() 
 
