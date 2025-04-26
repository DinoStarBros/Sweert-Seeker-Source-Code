extends StatePlr

func on_enter()-> void:
	pass

func process(delta: float)-> void:
	if p.velocity.x >= -p.acceleration and p.velocity.x <= p.acceleration:
		p.anim.play("idle")
	else:
		p.anim.play("walk")
	
	p.x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	p.velocity_weight = delta * (p.acceleration if p.x_input else p.friction)
	p.velocity.x = lerp(p.velocity.x, p.x_input * p.max_speed, p.velocity_weight)
	
	if Input.is_action_just_pressed("Jump") and p.is_on_floor():
		p.sm.change_state("jump")
		
	if p.velocity.y >= 10:
		p.sm.change_state("fall")
	
	if Input.is_action_just_pressed("Slash"):
		p.sm.change_state("slash")

func on_exit()-> void:
	pass
