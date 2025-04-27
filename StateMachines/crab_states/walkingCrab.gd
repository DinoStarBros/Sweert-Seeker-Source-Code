extends StateCrab

var dir : int = 1
func on_enter()-> void:
	pass

func process(_delta: float)-> void:
	#%floor_detect.position.x = dir * 50
	
	p.velocity.x = dir * p.speed
	
	if not %floor_detect.is_colliding() or %wall_detect.is_colliding():
		dir *= -1
		%fd_pivot.scale.x = -%fd_pivot.scale.x
	
	%"CrabEnemy-sheet".flip_h = dir == 1

func on_exit()-> void:
	pass
