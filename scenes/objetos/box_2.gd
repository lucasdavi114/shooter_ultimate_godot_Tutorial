extends ObjetoGenerico

func hit():
	$Lid.hide()
	if not opened:
		for i in range (3):
			var pos = $SpawnPositions.get_child(randi() % $SpawnPositions.get_child_count()).global_position
			open.emit(pos, current_direction)
			$AudioStreamPlayer2D.play()
	opened = true
