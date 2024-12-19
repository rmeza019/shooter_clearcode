extends CharacterBody2D

var speed = 300.0
var active:bool = false
var vulnerable:bool = true
var health:int = 50

func _ready() -> void:
	$Explosion.hide()

func _process(_delta: float) -> void:
	if active:
		var offset = PI / 2 
		look_at(Globals.player_pos)
		rotation += offset
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		move_and_slide()

func hit():
	if vulnerable:
		vulnerable = false
		$HitTimer.start()
		health -= 10
	
	if health <= 0:
		$AnimationPlayer.play("explosion")

func _on_notice_area_body_entered(body: Node2D) -> void:
	active = true

func _on_hit_timer_timeout() -> void:
	vulnerable = true
