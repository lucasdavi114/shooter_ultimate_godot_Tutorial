extends StaticBody2D

signal Player_Entrou_na_Area(body: Node2D)
signal Player_Saiu_Da_Area(body: Node2D)

func _on_area_2d_body_entered(body: Node2D) -> void:
	Player_Entrou_na_Area.emit(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	Player_Saiu_Da_Area.emit(body)
