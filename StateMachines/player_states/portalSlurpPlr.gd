extends StatePlr


func on_enter()-> void:
	p.anim.play("portalSlurp")
	#for n in %music.get_children():
	#	if n is AudioStreamPlayer:
	#		n.stop()

func process(_delta: float)-> void:
	p.velocity = Vector2.ZERO

func on_exit()-> void:
	pass
