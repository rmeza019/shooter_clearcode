extends ItemContainer

func hit() -> void:
	print(current_direction)
	$LidSprite.hide()
	var pos = $SpawnPositions.get_child(randi() % $SpawnPositions.get_child_count()).global_position
	spawn_item.emit(pos, current_direction)
