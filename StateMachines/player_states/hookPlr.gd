extends StatePlr


func on_enter()-> void:
	p.slashes_in_air = 0
	p.anim.play("hook")
	#if not p.grapple_controller.swinging:
	#	%plrcol.disabled = true
	pass

func process(delta: float)-> void:
	#p.x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	#print(p.x_input)
	#if p.x_input != 0:
	#	p.velocity_weight = delta * (p.acceleration if p.x_input else p.friction)
	#	p.velocity.x = lerp(p.velocity.x, p.x_input * p.max_speed, p.velocity_weight)
	
	if Input.is_action_just_pressed("Slash"):
		%slashanim.play("slash")
		%slash_pivot.look_at(p.get_global_mouse_position())
	#pass

func on_exit()-> void:
	pass
