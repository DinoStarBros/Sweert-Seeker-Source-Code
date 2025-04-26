extends StateDrone

var shoot_timer : float = 0
func on_enter()-> void:
	shoot_timer = 1

func process(delta: float)-> void:
	var dir_to_plr : Vector2 = p.global_position.direction_to(g.player.global_position)
	var dist_to_plr : float = p.global_position.distance_to(g.player.global_position)
	
	if dist_to_plr > 200:
		p.velocity = dir_to_plr * p.speed
	else:
		p.velocity = -dir_to_plr * (p.speed / 2)
	
	shoot_timer -= delta
	if shoot_timer <= 0:
		if dist_to_plr <= 500:
			p.spawn_bullet()
		shoot_timer = 1

func on_exit()-> void:
	pass
