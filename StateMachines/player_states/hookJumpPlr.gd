extends StatePlr

func on_enter()-> void:
	p.anim.play("hookJump")
	p.velocity *= 1.3

func process(delta: float)-> void:
	if p.is_on_floor():
		p.sm.change_state("walk")
	
	p.x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	p.velocity_weight = delta * (p.acceleration if p.x_input else p.friction)
	p.velocity.x = lerp(p.velocity.x, p.x_input * p.max_speed, p.velocity_weight / 3)
	
	wall_cling_handling()
	
	if Input.is_action_just_pressed("Slash"):
		p.sm.change_state("slash")
	
	if p.velocity.y >= 0:
		p.sm.change_state("fall")

func on_exit()-> void:
	pass

func wall_cling_handling()-> void:
	var wall_clings : Array[bool] = [p.is_on_wall() and p.velocity.x < 0, p.is_on_wall() and p.velocity.x > 0]
	if wall_clings.count(true) == 1:
		if wall_clings[0]:
			p.wallcling_direction = -1
			p.sm.change_state("wallCling")
		if wall_clings[1]:
			p.wallcling_direction = 1
			p.sm.change_state("wallCling")
