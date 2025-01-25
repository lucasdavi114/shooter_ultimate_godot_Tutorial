extends CanvasLayer

# Cores
var green: Color = Color("6bbfa3")
var red: Color = Color("ff575f")

@onready var laser_label: Label = $MarginContainer2/Laser_counter/VBoxContainer/municao_laser
@onready var granade_label: Label = $MarginContainer3/Granade_counter/VBoxContainer/Label
@onready var texture_laser: TextureRect = $MarginContainer2/Laser_counter/VBoxContainer/TextureRect
@onready var texture_granade: TextureRect = $MarginContainer3/Granade_counter/VBoxContainer/TextureRect

func _ready() -> void:
	update_hud_laser_munition()
	update_hud_granade_munition()

func update_hud_laser_munition():
	laser_label.text = str(Globals.municao)
	change_Color(Globals.municao, laser_label, texture_laser)

func update_hud_granade_munition():
	granade_label.text = str(Globals.granadas)
	change_Color(Globals.granadas, granade_label, texture_granade)
	
func change_Color(ammount: int, label: Label, icon: TextureRect) -> void:
	
	if ammount <= 0:
		label.modulate = red
		icon.modulate = red
	else:
		label.modulate = green
		icon.modulate = green
