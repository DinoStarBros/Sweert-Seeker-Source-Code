extends TileMapLayer

@export var enabled_during_escape : bool = false ## If true, it will have a collision during the escape, and be disabled during the non escape. Vice-Versa
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if enabled_during_escape:
		enabled = g.escape
	else:
		enabled = not g.escape
