extends Area2D

var item_types =  ['Health',  'Grenade',  'Laser', 'Laser', 'Laser', 'Laser']

var rotate_speed: int = 2
var item = item_types[randi()%len(item_types)]

func _ready() -> void:
	if item == 'Laser':
		$Sprite2D.modulate = Color(0.2, 0.2, 1)
	if item == 'Grenade':
		$Sprite2D.modulate = Color(1, 0.2, 0.2)
	if item == 'Health':
		$Sprite2D.modulate = Color(0.2, 1, 0.2)
func _process(delta: float) -> void:
	
	rotation += rotate_speed * delta


func _on_body_entered(_body: Node2D) -> void:
	if item == 'Grenade':
		Globals.granadas += 1
		
	if item == 'Laser':
		Globals.municao += 5 
	
	if item == 'Health':
		Globals.health += 10
		if Globals.health > 100:
			Globals.health = 100
	queue_free()
