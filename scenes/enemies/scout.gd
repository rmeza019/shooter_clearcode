extends CharacterBody2D

signal laser(pos, direction)

var player_nearby:bool = false
var can_laser:bool = true
var current_gun:bool = true

func _process(_delta: float) -> void:
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var pos:Vector2
			if current_gun:
				pos = $LaserSpawnPositions/Marker2D.global_position
			else:
				pos = $LaserSpawnPositions/Marker2D2.global_position
				
			var direction:Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			current_gun = not current_gun
			$LaserCooldown.start()


func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false


func _on_laser_cooldown_timeout() -> void:
	can_laser = true
