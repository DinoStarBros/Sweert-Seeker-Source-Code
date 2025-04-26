extends StateMR

func on_enter()-> void:
	recovery_time = 1
	p.a.play("slam")
	if %plrdetect.target_position.x > 0:
		%hitbox.rotation_degrees = 0
	else:
		%hitbox.rotation_degrees = 180

func process(delta: float)-> void:
			p.velocity.x = 0
			recovery_time -= delta
			if recovery_time <= 0:
				p.sm.change_state("idle")
			
			if %plrdetect.is_colliding():
					p.sm.change_state("jab")

func on_exit()-> void:
	pass
