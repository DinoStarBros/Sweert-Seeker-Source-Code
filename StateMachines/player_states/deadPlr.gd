extends StatePlr


func on_enter()-> void:
	p.anim.play("death")
	GlobalSignals.emit_signal("Reset_Room")

func process(_delta: float)-> void:
	p.velocity = Vector2.ZERO

func on_exit()-> void:
	#p.anim.play("walk")
	pass

func _init() -> void:
	GlobalSignals.connect("Player_Goto_Checkpoint", reset_room)

func reset_room() -> void:
	if p.checkpoint:
		p.global_position = p.checkpoint.global_position
	else:
		p.global_position = Vector2.ZERO
	await get_tree().create_timer(1).timeout
	p.anim.play("RESET")
	p.sm.change_state("walk")
	g.player_hp = 4
