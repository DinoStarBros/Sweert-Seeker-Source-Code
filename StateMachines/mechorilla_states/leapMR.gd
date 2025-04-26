extends StateMR

func on_enter()-> void:
	recovery_time = 2
	p.a.play("leap")

func process(delta: float)-> void:
	recovery_time -= delta
	if recovery_time <= 0:
		p.sm.change_state("idle")

func on_exit()-> void:
	pass

var rc_dir : Vector2
func leap() -> void:
	p.velocity.x *= 0.8
	rc_dir = (g.player.global_position - p.global_position).normalized()
	
	p.velocity = rc_dir * 1000
	p.velocity.y -= 600
