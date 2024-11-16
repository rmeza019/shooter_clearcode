extends RigidBody2D

@export var speed: int = 750

func explode() -> void:
	$AnimationPlayer.play("Explosion")
