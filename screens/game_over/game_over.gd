extends Node2D

func _ready() -> void:
	spawn_explosion(Vector2(randf_range(0, 1280), randf_range(0, 720)))
	await get_tree().create_timer(1).timeout
	for n in 2:
		spawn_explosion(Vector2(randf_range(0, 1280), randf_range(0, 720)))
	await get_tree().create_timer(1).timeout
	for n in 3:
		spawn_explosion(Vector2(randf_range(0, 1280), randf_range(0, 720)))
	await get_tree().create_timer(1).timeout
	
	explosion_barrage = true
	
	await get_tree().create_timer(3).timeout
	g.scene_change("res://screens/level_select/level_select.tscn")

func _process(_delta: float) -> void:
	pass

var explosion_scn : PackedScene = preload("res://projectiles/explosion_effect/explosion_effect.tscn")
func spawn_explosion(global_pos: Vector2) -> void:
	var explosion : Explosion = explosion_scn.instantiate()
	add_child(explosion)
	
	explosion.global_position = global_pos

var explosion_barrage : bool = false
func _on_explosion_timer_timeout() -> void:
	%explosionTimer.start(randf_range(0.05, 0.2))
	for n in randi_range(1, 7):
		if explosion_barrage:
			spawn_explosion(Vector2(randf_range(0, 1280), randf_range(0, 720)))
