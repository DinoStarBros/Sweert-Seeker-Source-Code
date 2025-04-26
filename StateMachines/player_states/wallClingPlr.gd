extends StatePlr

func on_enter()-> void:
	p.anim.play("wallCling")

func process(_delta: float)-> void:
	if p.velocity.y > 0:

		
		if p.wallcling_direction == 1:
			if Input.is_action_pressed("Left"):
				p.sm.change_state("fall")
		elif p.wallcling_direction == -1:
			if Input.is_action_pressed("Right"):
				p.sm.change_state("fall")
	
	if Input.is_action_pressed("Down"):
		p.velocity.y *= 1
		
	elif Input.is_action_pressed("Up"):
		p.velocity.y = -p.max_speed * .7
		p.anim.play("wallClimb")
	else:
		if p.velocity.y > 0:
			p.velocity.y *= 0.8

	if p.is_on_floor():
		p.sm.change_state("fall")
	
	if Input.is_action_just_pressed("Jump"):
		p.sm.change_state("wallJump")
	
	if %left_wc.get_overlapping_bodies().size() < 1 and p.wallcling_direction == -1:
		p.sm.change_state("fall")
	
	if %right_wc.get_overlapping_bodies().size() < 1 and p.wallcling_direction == 1:
		p.sm.change_state("fall")
	
	if Input.is_action_just_pressed("Slash"):
		p.sm.change_state("slash")

func on_exit()-> void:
	pass
