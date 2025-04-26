extends StateMR

func on_enter()-> void:
	recovery_time = .9
	p.a.play("jab")
	if %plrdetect.target_position.x > 0:
		%hitbox.rotation_degrees = 0
	else:
		%hitbox.rotation_degrees = 180

func process(delta: float)-> void:
			p.velocity.x = 0
			recovery_time -= delta
			if recovery_time <= 0:
				p.sm.change_state("idle")

func on_exit()-> void:
	pass
