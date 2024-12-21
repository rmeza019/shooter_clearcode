extends PathFollow2D

var player_nearby:bool = false
@onready var line1:Line2D = $Turret/RayCast2D/Line2D
@onready var line2:Line2D = $Turret/RayCast2D2/Line2D
@onready var gunFire1:Sprite2D = $Turret/GunFire1
@onready var gunFire2:Sprite2D = $Turret/GunFire2

func _ready() -> void:
	line2.add_point($Turret/RayCast2D2.target_position)
	

func _process(delta: float) -> void:
	progress_ratio += 0.02 * delta
	
	if player_nearby:
		$Turret.look_at(Globals.player_pos)

func _on_notice_area_body_entered(body: Node2D) -> void:
	player_nearby = true
	$AnimationPlayer.play("laser_load")

func _on_notice_area_body_exited(body: Node2D) -> void:
	player_nearby = false
	$AnimationPlayer.pause()
	var tween =  create_tween()
	tween.set_parallel(true)
	tween.tween_property(line1,"width", 0, 0.5)
	tween.tween_property(line2,"width", 0, 0.5)
	await tween.finished
	$AnimationPlayer.stop()

func fire() -> void:
	Globals.health -= 20
	gunFire1.modulate.a = 1
	gunFire2.modulate.a = 1
	
	var tween =  create_tween()
	tween.set_parallel(true)
	tween.tween_property(gunFire1,"modulate:a", 0, 0.5)
	tween.tween_property(gunFire2,"modulate:a", 0, 0.5)
	
