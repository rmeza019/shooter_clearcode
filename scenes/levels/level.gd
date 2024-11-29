extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene:PackedScene = preload("res://scenes/items/item.tscn")

func _ready() -> void:
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("spawn_item", _on_container_opened)
		
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect("laser", _on_scout_laser)

func _on_container_opened(pos, direction) -> void:
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child', item)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	print("body entered")

func _on_player_laser(pos, direction) -> void:
	create_laser(pos, direction)

func _on_player_grenade(pos, direction) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)

func _on_scout_laser(pos, direction) -> void:
	create_laser(pos, direction)
	
func create_laser(pos, direction) -> void:
	var laser = laser_scene.instantiate() as Area2D
	
	laser.position = pos
	laser.direction = direction
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	
	$Projectiles.add_child(laser)
