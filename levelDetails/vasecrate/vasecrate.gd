extends Node2D

func _ready() -> void:

	%"LevelDetails-sheet".frame = randi_range(0, 2)
	if %"LevelDetails-sheet".frame == 2:
		modulate = Color.SANDY_BROWN
	else:
		modulate = Color.POWDER_BLUE
