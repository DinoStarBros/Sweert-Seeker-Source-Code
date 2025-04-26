extends StatePlr
var check_wcling : bool = false

func on_enter()-> void:
	p.slashes_in_air = 1
	p.velocity.y = -p.jump_velocity
	
	p.anim.play("wallJump")
	
	check_wcling = false
	await get_tree().create_timer(0.05).timeout
	check_wcling = true

func process(_delta: float)-> void:
	if check_wcling:
		wall_cling_handling()
	

	#if not Input.is_action_pressed("Jump"):
	#	p.velocity.y *= 0.8
	
	if p.velocity.y >= 0:
		p.sm.change_state("fall")
	
	if Input.is_action_just_pressed("Slash"):
		p.sm.change_state("slash")
	

func on_exit()-> void:
	pass

func wall_cling_handling()-> void:
	p.velocity.x = p.wallcling_direction * -0.8 * p.dash_velocity
	
	#var wall_clings : Array[bool] = [%left_wall_cling.is_colliding(), %right_wall_cling.is_colliding()]
	var wall_clings : Array[bool] = [p.velocity.x < 0, p.velocity.x > 0]
	#var wall_clings : Array[bool] = [%left_wc.get_overlapping_bodies().size() > 0, %right_wc.get_overlapping_bodies().size() > 0]
	
	if wall_clings.count(true) == 1 and p.is_on_wall():

		if wall_clings[0]:
			p.wallcling_direction = -1
			p.sm.change_state("wallCling")
		if wall_clings[1]:
			p.wallcling_direction = 1
			p.sm.change_state("wallCling")
