extends Node2D

var value : int = 0
func _ready() -> void:
	value = randi_range(0, 2)
	%"LevelDetails-sheet".frame = value
	
	if value == 2:
		modulate = Color.SANDY_BROWN
	else:
		match value:
			0:
				modulate = Color.PURPLE
			1:
				modulate = Color.BLUE_VIOLET
			2:
				modulate = Color.POWDER_BLUE
