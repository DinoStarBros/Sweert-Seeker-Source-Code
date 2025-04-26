extends Node2D
class_name Explosion

func _ready() -> void:
	%anim.speed_scale = randf_range(0.8, 1.2)
	%boom.pitch_scale = randf_range(0.5, 1.2)
	%boom.play()
	%"Shockwave-sheet".scale.x = randf_range(1, 1.5)
	%"Shockwave-sheet".scale.y = %"Shockwave-sheet".scale.x

func _process(_delta: float) -> void:
	pass
