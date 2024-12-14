extends CharacterBody2D

var speed:int = 300
var player_nearby:bool = false
var can_attack:bool = true
var health:int = 20
var is_vulnerable:bool = true
var is_active:bool = false

func _process(_delta: float) -> void:
	var direction:Vector2 = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	
	if is_active:
		move_and_slide()
		var offset = PI / 2 
		look_at(Globals.player_pos)
		rotation += offset

func hit():	
	if is_vulnerable:
		health -= 10
		$Timers/HitTimer.start()
		is_vulnerable = false
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
		$Particles/HitParticles.emitting = true
	if health <= 0:
		await get_tree().create_timer(0.5)
		queue_free()

func _on_attack_area_body_entered(body: Node2D) -> void:
	player_nearby = true
	print("you gonna get messed up son")
	if can_attack:
		can_attack = false
		$AnimatedSprite2D.play("attack")
		if "hit" in body:
			body.hit()
			$Timers/AttackTimer.start()

func _on_attack_area_body_exited(body: Node2D) -> void:
	player_nearby = false
	print("oi come back!")
	$AnimatedSprite2D.play("walk")

func _on_notice_area_body_entered(_body: Node2D) -> void:
	is_active = true
	$AnimatedSprite2D.play("walk")
	print("I see u there MF")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	is_active = false
	$AnimatedSprite2D.stop()
	print("where u go?")

func _on_hit_timer_timeout() -> void:
	is_vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)

func _on_attack_timer_timeout() -> void:
	$AnimatedSprite2D.play("attack")
	can_attack = true
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if player_nearby:
		Globals.health -= 10
		$Timers/AttackTimer.start()
