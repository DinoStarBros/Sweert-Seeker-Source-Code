extends StateOrb

var shoot_timer : float = 0

const l_shootime : float = 0.4
const r_shootime : float = 0.5
func on_enter()-> void:
	shoot_timer = randf_range(l_shootime, r_shootime)

func process(delta: float)-> void:
	#var dir_to_plr : Vector2 = p.global_position.direction_to(g.player.global_position)
	var dist_to_plr : float = p.global_position.distance_to(g.player.global_position)
	
	shoot_timer -= delta
	if shoot_timer <= 0:
		if dist_to_plr <= 1500:
			#for n in randi_range(7, 10):
			p.spawn_bullet()
		
		shoot_timer = randf_range(l_shootime, r_shootime)

func on_exit()-> void:
	pass
