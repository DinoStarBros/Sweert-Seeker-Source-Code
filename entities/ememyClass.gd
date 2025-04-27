extends CharacterBody2D
class_name Enemy


func hurt(_attack_position : Vector2) -> void:
	pass

func _init() -> void:
	GlobalSignals.connect("Reset_Room", reset)

func reset() -> void:
	pass

func _ready() -> void:
	set_collision_layer_value(14, true)
	set_collision_mask_value(14, true)
