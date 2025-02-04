extends PathFollow2D

var player_nearby: bool = false

@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D

@onready var gunfire1: Sprite2D = $Turret/GunFire1
@onready var gunfire2: Sprite2D = $Turret/GunFire2

func fire():
	Globals.health -= 20
	gunfire1.modulate.a = 1
	gunfire2.modulate.a = 1
	
	var tween = create_tween()
	
	tween.set_parallel()
	tween.tween_property(gunfire1, "modulate:a", 0, randf_range(0.1, 0.5))
	tween.tween_property(gunfire2, "modulate:a", 0, randf_range(0.1, 0.5))

func _process(delta: float) -> void:
	progress_ratio += 0.02 * delta
	if player_nearby:
		$Turret.look_at(Globals.player_position)

func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_nearby = true
	$AnimationPlayer.play("laser_load")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	player_nearby = false
	$AnimationPlayer.pause()
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(line1, "width", 0, randf_range(0.1, 0.5))
	tween.tween_property(line2, "width", 0, randf_range(0.1, 0.5))
	await tween.finished
	$AnimationPlayer.stop()
