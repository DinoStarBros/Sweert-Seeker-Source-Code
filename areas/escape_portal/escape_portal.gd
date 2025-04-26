extends Area2D
class_name EscapePortal

var opened : bool = false
func _ready() -> void:
	await %anim.animation_finished
	%anim.play("close_loop")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.sm.change_state("portalSlurp")
		finsh()
		g.escape = false

func finsh() -> void:
	await get_tree().create_timer(2).timeout
	g.scene_change("res://screens/victory/victory.tscn")

func _init() -> void:
	GlobalSignals.connect("Start_Escape", escape_start)

func escape_start() -> void:
	opened = true
	%anim.play("opened_loop")
