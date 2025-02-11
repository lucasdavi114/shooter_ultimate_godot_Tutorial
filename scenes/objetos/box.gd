extends ObjetoGenerico

func hit():
	if opened == false:
		$Lid.hide()
		for i in range (5):
			var pos = $SpawnPositions.get_child(randi() % $SpawnPositions.get_child_count()).global_position
			open.emit(pos, current_direction)
			$AudioStreamPlayer2D.play()
	opened = true
