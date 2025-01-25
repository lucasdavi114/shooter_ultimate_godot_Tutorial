extends StaticBody2D

signal Player_Entrou_na_Area()
signal Player_Saiu_Da_Area()

func _on_area_2d_body_entered(_body) -> void:
		Player_Entrou_na_Area.emit()


func _on_area_2d_body_exited(_body) -> void:
		Player_Saiu_Da_Area.emit()
	
