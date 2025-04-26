extends StateOrb

func on_enter()-> void:
	p.a.play("hooked")

func process(_delta: float)-> void:
	var dir_to_mouse : = p.global_position.direction_to(p.get_global_mouse_position())
	p.velocity = dir_to_mouse * 100

func on_exit()-> void:
	pass
