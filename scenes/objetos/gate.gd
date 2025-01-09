extends StaticBody2D

signal Player_Entrou_na_Area(body)
signal Player_Saiu_Da_Area(body)

func _on_area_2d_body_entered(body) -> void:
		Player_Entrou_na_Area.emit(body)


func _on_area_2d_body_exited(body) -> void:
		Player_Saiu_Da_Area.emit(body)
	
