extends StatePlr

var jump_pressed: bool = false
var jump_buffer_time: float = 0

func on_enter()-> void:
	p.anim.play("fall")
	jump_pressed = false

func process(delta: float)-> void:
	
	p.x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	p.velocity_weight = delta * (p.acceleration if p.x_input else p.friction)
	p.velocity.x = lerp(p.velocity.x, p.x_input * p.max_speed, p.velocity_weight/2)
	
	if p.is_on_floor():
		p.sm.change_state("walk")
	jump_buffer_handling(delta)
	coyote_time_handling()

	if Input.is_action_just_pressed("Slash"):
		p.sm.change_state("slash")
	
	
	wall_cling_handling()

func on_exit()-> void:
	pass

func jump_buffer_handling(delta: float)-> void:
	if Input.is_action_just_pressed("Jump"):
		jump_pressed = true
	if jump_pressed:
		jump_buffer_time += delta
	else:
		jump_buffer_time = 0
	if jump_buffer_time >= 0.01 and jump_buffer_time <= 0.2:
		if p.is_on_floor():
			p.sm.change_state("jump")

func coyote_time_handling()-> void:
	if p.coyote_time <= 0.07:
		if Input.is_action_just_pressed("Jump"):
			p.sm.change_state("jump")

func wall_cling_handling()-> void:
	#var wall_clings : Array[bool] = [%left_wall_cling.is_colliding(), %right_wall_cling.is_colliding()]
	#var wall_clings : Array[bool] = [p.is_on_wall() and p.velocity.x < -1, p.is_on_wall() and p.velocity.x > 1]
	
	var wall_clings : Array[bool] = [p.is_on_wall() and p.velocity.x < 0, p.is_on_wall() and p.velocity.x > 0]
	if wall_clings.count(true) == 1:
		if wall_clings[0]:
			p.wallcling_direction = -1
			p.sm.change_state("wallCling")
		if wall_clings[1]:
			p.wallcling_direction = 1
			p.sm.change_state("wallCling")
