extends ItemContainer

func hit() -> void:
	if not opened:
		$LidSprite.hide()
		for i in range(3):
			var pos = $SpawnPositions.get_child(randi() % $SpawnPositions.get_child_count()).global_position
			spawn_item.emit(pos, current_direction)
		opened = true
