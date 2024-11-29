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
		
var health:int = 60:
	set(value):
		health = value
		stats_change.emit()

var player_pos:Vector2
