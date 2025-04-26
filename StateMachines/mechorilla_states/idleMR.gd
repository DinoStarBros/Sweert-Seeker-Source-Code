extends StateMR

var slam_timer : float
func on_enter()-> void:
	p.velocity = Vector2.ZERO
	slam_timer = randf_range(0.5, 1)

var rc_dir : Vector2
const rc_length : int = 100

func process(delta: float)-> void:
	rc_dir = (g.player.global_position - p.global_position).normalized()
	%plrdetect.target_position = rc_dir * rc_length
	
	#p.velocity.x = %plrdetect.target_position.normalized().x * 100
	if p.global_position.distance_to(g.player.global_position) <= 1000:
		if %plrdetect.is_colliding():
			p.sm.change_state("jab")
		else:
			slam_timer -= delta
			if slam_timer <= 0:
				if randf() <= 0.5:
					p.sm.change_state("slam")
				else:
					p.sm.change_state("leap")

func on_exit()-> void:
	pass
