extends Area2D
class_name CheckPointArea

var checkpoint : Node2D
func _ready() -> void:
	for n in get_children():
		if n is Node2D:
			checkpoint = n
