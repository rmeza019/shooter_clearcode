extends CharacterBody2D

var player_nearby:bool = false
var can_attack:bool = true
var health:int = 25
var is_vulnerable:bool = true

func _process(_delta: float) -> void:
	if player_nearby:
		var offset = PI / 2 
		look_at(Globals.player_pos)
		rotation += offset
		
		if can_attack:
			var pos:Vector2
			
			var direction:Vector2 = (Globals.player_pos - position).normalized()
			
			can_attack = false
			$Timers/AttackTimer.start()

func hit():	
	if is_vulnerable:
		health -= 10
		$Timers/HitTimer.start()
		is_vulnerable = false
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
	if health <= 0:
			queue_free()

func _on_attack_area_body_entered(body: Node2D) -> void:
	print("you gonna get messed up son")

func _on_attack_area_body_exited(body: Node2D) -> void:
	print("oi come back!")

func _on_notice_area_body_entered(body: Node2D) -> void:
	player_nearby = true
	print("I see u there MF")

func _on_notice_area_body_exited(body: Node2D) -> void:
	player_nearby = false
	print("where u go?")
