extends ItemContainer

func hit() -> void:
	if not opened:
		$LidSprite.hide()
		var pos = $SpawnPositions/Marker2D.global_position
		spawn_item.emit(pos, current_direction)
		opened = true
