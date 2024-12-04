extends Node

signal stats_change

var laser_amount:int = 25:
	set(value):
		laser_amount = value
		stats_change.emit()
		
var grenade_amount:int = 5:
	set(value):
		grenade_amount =value
		stats_change.emit()

var player_vulnerable:bool = true
var health:int = 60:
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if player_vulnerable:
				health = value
				player_vulnerable = false
				player_invulnerable_timer()
				stats_change.emit()

var player_pos:Vector2

func player_invulnerable_timer() -> void:
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true
