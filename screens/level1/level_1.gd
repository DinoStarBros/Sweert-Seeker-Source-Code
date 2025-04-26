extends Node2D

func _ready() -> void:
	g.gem_fragments_collected.clear()
	g.escape_time = 180
	g.escape = false
	
	g.entity_container = %entities
	g.projectile_container = %projectiles
	
	g.leveL_music_idx = 1

func _process(_delta: float) -> void:
	pass
