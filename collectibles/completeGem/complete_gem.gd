extends Area2D
class_name CompleteGem

@onready var fragment_sprites : Array[Sprite2D] = [
	%"0",
	%"1",
	%"2",
	%"3"
]

var hovered : bool = false
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	for n in g.gem_fragments_collected:
		fragment_sprites[n].show()

func collect() -> void:
	g.frame_freeze(0.4, .3)
	g.camera.screen_shake(10, 1)
	
	%slashed.play()
	%slashed2.play()
	%anim.play("collect")
	GlobalSignals.emit_signal("Start_Escape")

	g.escape = true

func _on_body_entered(body: Player) -> void:
	if body is Player:
		hovered = true

func _on_body_exited(body: Player) -> void:
	if body is Player:
		hovered = false
