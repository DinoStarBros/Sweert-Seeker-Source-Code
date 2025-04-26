extends Area2D
class_name EncounterArea

var encounter_done : bool = false
var encountering : bool = false
var barriers : TileMapLayer
@export var debug_text : Label
func _ready() -> void:
	
	set_collision_layer_value(13 ,true)
	set_collision_mask_value(13 ,true)
	set_collision_layer_value(14 ,true)
	set_collision_mask_value(14 ,true)
	
	for child in get_children():
		if child is EnemySpawner:
			enemy_spawners.append(child)
		if child is TileMapLayer:
			barriers = child

var check_for_enemy_count_in_area : bool =false
var time_in_encounter : float = 0
func _process(delta: float) -> void:
	barriers.enabled = encountering
	
	if debug_text:
		#pass
		debug_text.text = str(get_overlapping_bodies(), "\n", encounter_done)
	
	if encountering:
		time_in_encounter += delta
		
		if time_in_encounter >= 2 and get_overlapping_bodies().size() <= 0:
			encountering = false
			if g.player_hp >= 1:
				encounter_done = true
				
			else:
				encounter_done = false

var enemy_spawners : Array[EnemySpawner]
# 0 = Crab : 1 = Drone : 2 = Mechorilla : 3 = Orb : 4 = Sentry
func encounter_start() -> void:
	for spawner in enemy_spawners:
		spawner.play_anim()
		time_in_encounter = 0

func _init() -> void:
	GlobalSignals.connect("Start_Escape", escape_start)
	GlobalSignals.connect("Reset_Room", reset)

func reset() -> void:
	for n in get_overlapping_bodies():
		n.queue_free()

func escape_start() -> void:
	encounter_done = false
