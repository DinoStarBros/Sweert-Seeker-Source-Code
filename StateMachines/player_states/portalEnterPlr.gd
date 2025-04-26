extends StatePlr


func on_enter()-> void:
	await get_tree().create_timer(0.1).timeout
	
	p.anim.play_backwards("portalSlurp")
	await p.anim.animation_finished
	p.sm.change_state("walk")

func process(_delta: float)-> void:
	p.velocity = Vector2.ZERO

func on_exit()-> void:
	pass
