extends Area2D
class_name RoomArea

var room : CollisionShape2D
func _ready() -> void:
	room = get_child(0)
