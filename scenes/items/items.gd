extends Area2D

var item_types = ['Health', 'Health', 'Health', 'Grenade', 'Grenade', 'Grenade', 'Laser', 'Laser', 'Laser', 'Laser']

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


func _on_body_entered(body: Node2D) -> void:
	body.add_item(item)
	queue_free()
