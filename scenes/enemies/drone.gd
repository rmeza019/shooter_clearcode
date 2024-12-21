extends CharacterBody2D

var max_speed:int = 600
var speed:int = 0
var active:bool = false
var vulnerable:bool = true
var health:int = 50
var explosion_radius:int = 400
var is_exploding:bool = false
var speed_multiplier:int = 1

func _ready() -> void:
	$Explosion.hide()
	$Sprite2D.show()

func _process(delta: float) -> void:
	if active:
		var offset = PI / 2 
		look_at(Globals.player_pos)
		rotation += offset
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * max_speed * speed_multiplier
		var collision = move_and_collide(velocity * delta)
		
		if collision:
			$AnimationPlayer.play("explosion")
			var targets = get_tree().get_nodes_in_group("Entities") + get_tree().get_nodes_in_group("Container")
			for target in targets:
				var in_range = target.global_position.distance_to(global_position) < explosion_radius
				if "hit" in target and in_range:
					target.hit()
			stop_movement()

func hit():
	if vulnerable:
		vulnerable = false
		$HitTimer.start()
		health -= 10
		$Sprite2D.material.set_shader_parameter("progress", 1)
	
	if health <= 0:
		$AnimationPlayer.play("explosion")

func _on_notice_area_body_entered(body: Node2D) -> void:
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6)

func _on_hit_timer_timeout() -> void:
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
	
func stop_movement() -> void:
	speed_multiplier = 0
