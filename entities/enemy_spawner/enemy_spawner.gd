extends Node2D
class_name EnemySpawner

var enemy_scenes : Array[PackedScene] = [
	preload("res://entities/crab/crab.tscn"),
	preload("res://entities/drone/drone.tscn"),
	preload("res://entities/mechorilla/mechorilla.tscn"),
	preload("res://entities/orb/orb.tscn"),
	preload("res://entities/sentry/sentry.tscn"),
]

@export var enemy_index : int ## 0 = Crab : 1 = Drone : 2 = Mechorilla : 3 = Orb : 4 = Sentry

func play_anim() -> void:
	%anim.play("spawn")

func spawn_enemy() -> void:
	var enemy_scn : PackedScene = enemy_scenes[enemy_index]
	var enemy : Enemy = enemy_scn.instantiate()
	g.entity_container.add_child(enemy)
	enemy.global_position = global_position
