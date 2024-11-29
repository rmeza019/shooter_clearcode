extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true
@export var max_speed: int = 500
var speed: int = max_speed

signal laser(pos, direction)
signal grenade(pos, direction)

func _process(_delta: float) -> void:
	#input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	
	#player rotation
	look_at(get_global_mouse_position())
	var player_direction:Vector2

	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$TimerLaser.start()
		player_direction = (get_global_mouse_position() - position).normalized()
		laser.emit(selected_laser.global_position, player_direction)

	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		var grenade_markers = $GrenadeStartPositions.get_children()
		var selected_grenade = grenade_markers[randi() % grenade_markers.size()]
		can_grenade = false
		$TimerGrenade.start()
		player_direction = (get_global_mouse_position() - position).normalized()
		grenade.emit(selected_grenade.global_position, player_direction)

func _on_timer_laser_timeout() -> void:
	can_laser = true

func _on_timer_grenade_timeout() -> void:
	can_grenade = true
