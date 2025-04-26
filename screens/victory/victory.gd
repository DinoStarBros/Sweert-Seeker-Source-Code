extends Node2D

@onready var fragment_sprites : Array[Sprite2D] = [
	%"0",
	%"1",
	%"2",
	%"3"
]

func _ready() -> void:
	pass

var sin_val : float = 0
func _process(delta: float) -> void:
	sin_val += delta
	if sin_val >= 180:
		sin_val = 0
	
	%fragments.global_position.y += sin(sin_val) * 20 * delta
	for n in g.gem_fragments_collected:
		fragment_sprites[n].show()
	
	if Input.is_action_just_pressed("Jump"):
		g.scene_change("res://screens/level_select/level_select.tscn")
