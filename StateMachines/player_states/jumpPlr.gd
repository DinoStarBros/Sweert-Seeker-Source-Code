extends StatePlr

func on_enter()-> void:
	p.anim.play("jump")
	p.velocity.y = -p.jump_velocity

func process(delta: float)-> void:
	
	p.x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	p.velocity_weight = delta * (p.acceleration if p.x_input else p.friction)
	p.velocity.x = lerp(p.velocity.x, p.x_input * p.max_speed, p.velocity_weight/2)
	
	if not Input.is_action_pressed("Jump"):
		p.velocity.y *= 0.8
	
	if p.velocity.y >= 0:
		p.sm.change_state("fall")

	if Input.is_action_just_pressed("Slash"):
		p.sm.change_state("slash")
	
	if p.is_on_floor():
		p.sm.change_state("walk")
	
	
	wall_cling_handling()

func on_exit()-> void:
	pass


func wall_cling_handling()-> void:
	#var wall_clings : Array[bool] = [%left_wall_cling.is_colliding(), %right_wall_cling.is_colliding()]
	var wall_clings : Array[bool] = [p.is_on_wall() and p.velocity.x < -1, p.is_on_wall() and p.velocity.x > 1]
	if wall_clings.count(true) == 1:
		if wall_clings[0]:
			p.wallcling_direction = -1
			p.sm.change_state("wallCling")
		if wall_clings[1]:
			p.wallcling_direction = 1
			p.sm.change_state("wallCling")
