extends Area2D
class_name GemFragment

@export var crystal_fragment_index : int ## 0 = top left fragment : 1 = top right fragment : 2 = bottom left fragment : 3 = bottom right fragment

@onready var sprite_fragments : Array[Sprite2D] = [
	%"0",
	%"1",
	%"2",
	%"3"
]

func _ready() -> void:
	for sprite in sprite_fragments:
		sprite.hide()
	
	sprite_fragments[crystal_fragment_index].show()

var collected : bool = false
var sin_val : float = 0
func _process(delta: float) -> void:
	sin_val += delta * 2
	if sin_val >= 180:
		sin_val = 0
	%fragments.position.y = sin(sin_val) * 10

func collect() -> void:
	
	for n in %sfx.get_children():
		if n is AudioStreamPlayer:
			n.pitch_scale += randf_range(-0.1, 0.1)
	
	%collect2.play()
	%collect1.play()
	%anim.play("collected")
	g.gem_fragments_collected.append(crystal_fragment_index)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		collect()
