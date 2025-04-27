extends Node2D

const enemy_amnt : float = 0
var cam_size : Vector2
func _ready() -> void:
	g.gem_fragments_collected.clear()
	g.escape_time = 180
	g.escape = false
	
	cam_size.x = 1280 / g.camera.zoom.x
	cam_size.y = 720 / g.camera.zoom.y
	
	g.leveL_music_idx = 0
	
	print("JUST A REMINDER, FOR ALL THE ROOM AREAS USED FOR CAMERA SNAPPING
The size has to be atleast", floor(cam_size) ,"to fit the Camera, the camera will bug out if it's smaller than the camera's size")
	print("NOTES : ")
	print("The player can jump up 4 tiles,
and across 20 tiles")
	g.entity_container = %entities
	g.projectile_container = %projectiles
	
	for n in enemy_amnt:
		spawn_enemy(n)

var enemy_scns : Array[PackedScene] = [
	preload("res://entities/mechorilla/mechorilla.tscn"),
	preload("res://entities/drone/drone.tscn"),
	preload("res://entities/orb/orb.tscn"),
	preload("res://entities/crab/crab.tscn")
]

func spawn_enemy(n : float) -> void:
	%PathFollow2D.progress_ratio = n / enemy_amnt
	var enemy : Enemy = enemy_scns.pick_random().instantiate()
	g.entity_container.add_child(enemy)
	enemy.global_position = %PathFollow2D.global_position

func _on_escapeshaketimer_timeout() -> void:
	if g.escape:
		g.camera.screen_shake(10, 1)
