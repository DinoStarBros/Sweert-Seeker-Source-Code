extends StateMR

func on_enter()-> void:
	p.a.play("hooked")

func process(_delta: float)-> void:
	var dir_to_mouse : = p.global_position.direction_to(p.get_global_mouse_position())
	p.velocity.x = dir_to_mouse.x * 300

func on_exit()-> void:
	pass
