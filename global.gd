extends Node

const gravity : float = 1200

var escape_time : float = 0
func scene_change(scene : String) -> void:
	SceneManager.change_scene(
		scene, {
			
			"pattern_enter" : "fade",
			"pattern_leave" : "fade",
			
			}
		)

var master_volume : float = 0.75
var music_volume : float = 0.75
var sfx_volume : float = 0.75

var screen_shake_value : bool = true 
var frame_freeze_value : bool = true

var resolution_index : int = 2

func frame_freeze(timescale: float, duration: float) -> void: ## Slows down the engine's time scale, slowing down the time, for a certain duration. Use for da juice
	if frame_freeze_value:
		Engine.time_scale = timescale
		await get_tree().create_timer(duration, true, false, true).timeout
		Engine.time_scale = 1.0

var camera : Cam

var entity_container : Node2D
var projectile_container : Node2D

var player : Player
var player_max_hp : int = 4
var player_hp : int = 4

func _process(_delta:float)->void:
	AudioServer.set_bus_volume_db(
		0,
		linear_to_db(master_volume)
	)
	AudioServer.set_bus_volume_db(
		1,
		linear_to_db(music_volume)
	)
	AudioServer.set_bus_volume_db(
		2,
		linear_to_db(sfx_volume)
	)

var escape : bool = false ## If false, just normal level, if true, it's sugar rush, a timed escape sequence
var gem_fragments_collected : Array[int]
var times_up : bool = false

var leveL_music_idx : int = 0 ## 0 = tutorial, Lvl 1 2 3
