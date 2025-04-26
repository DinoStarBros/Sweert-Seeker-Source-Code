extends StatePlr

var recovery_time: float = 0

func on_enter()-> void:
	slash_dash()

func process(delta: float)-> void:
	p.x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	p.velocity_weight = delta * (p.acceleration if p.x_input else p.friction)
	p.velocity.x = lerp(p.velocity.x, p.x_input * p.max_speed, p.velocity_weight/5)

	p.velocity *= 0.95
	recovery_time -= delta
	
	if recovery_time <= 0:
		p.sm.change_state("walk")

func on_exit()-> void:
	%Trail2.hide()
	%CollisionShape2D.disabled = true
var direction_to_dash
func slash_dash() -> void:
	%slash_pivot.look_at(p.get_global_mouse_position())
	#p.anim.play("slash")
	%slashanim.play("slash")
	direction_to_dash = (p.get_global_mouse_position() - p.global_position).normalized()
	if p.is_on_floor():
		p.velocity.x = direction_to_dash.x * p.dash_velocity
		p.velocity.y = direction_to_dash.y * p.dash_velocity
	else:
		p.slashes_in_air += 1
		p.velocity.x = direction_to_dash.x * p.dash_velocity * (1 / p.slashes_in_air)
		p.velocity.y = direction_to_dash.y * p.dash_velocity * (1 / p.slashes_in_air)
		#p.velocity.y -= 50
	
	recovery_time = .3
