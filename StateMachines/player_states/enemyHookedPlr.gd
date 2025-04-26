extends StatePlr

var latch_duration : float = 0
func on_enter()-> void:
	p.slashes_in_air = 0.5
	%HeartJavelin.show()
	p.velocity = Vector2.ZERO
	p.grapple_controller.raycast_collider.sm.change_state("hooked")
	latch_duration = 2

func process(delta: float)-> void:
	p.velocity = Vector2.ZERO
	
	#p.x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	#p.velocity_weight = delta * (p.acceleration if p.x_input else p.friction)
	#p.velocity.x = lerp(p.velocity.x, p.x_input * p.max_speed, p.velocity_weight / 4)
	
	#p.grapple_controller.raycast_collider.global_position = p.global_position
	
	latch_duration -= delta
	if p.grapple_controller.swing_mode == "enemyHook":
		#if Input.is_action_just_released("Grapple"):
		if not Input.is_action_pressed("Grapple") or latch_duration <= 0:
			var dir_to_mouse : Vector2 = p.global_position.direction_to(p.get_global_mouse_position())
			
			p.velocity = dir_to_mouse * p.dash_velocity
			p.velocity.y *= 0.8
			
			p.sm.change_state("hookJump")
			
			if p.grapple_controller.raycast_collider is Enemy:
				%slashanim.play("slash")
				p.grapple_controller.raycast_collider.hurt(p.global_position)
				p.grapple_controller.retract()
				%slash_pivot.look_at(p.get_global_mouse_position())
		else:
			p.global_position = p.grapple_controller.raycast_collider.global_position + Vector2(-30, -30)

func on_exit()-> void:
	%HeartJavelin.hide()
