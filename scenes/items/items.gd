extends Area2D

var item_types =  ['Health',  'Grenade',  'Health', 'Laser', 'Laser', 'Laser']

var rotate_speed: int = 2
var item = item_types[randi()%len(item_types)]

var direction: Vector2
var distance: int = randi_range(150, 250)

func _ready() -> void:
	if item == 'Laser':
		$Sprite2D.modulate = Color(0.2, 0.2, 1)
	if item == 'Grenade':
		$Sprite2D.modulate = Color(1, 0.2, 0.2)
	if item == 'Health':
		$Sprite2D.modulate = Color(0.2, 1, 0.2)
		
	#tweens 
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).from(Vector2(0, 0))
	
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
