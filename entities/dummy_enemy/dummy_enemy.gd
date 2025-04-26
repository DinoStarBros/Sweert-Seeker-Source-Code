extends Enemy
class_name Dummy

var grappled : bool = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func hurt(attack_position : Vector2) ->void:
	g.camera.screen_shake(5, 0.2)
	g.frame_freeze(0.5, 0.2)
	
	%anim.play("death")
	
	var knock_dir : Vector2 = (global_position - attack_position).normalized()
	velocity = knock_dir * 1000
	%hitfx.look_at(to_global(global_position.direction_to(attack_position)))
	%hitfx.rotation_degrees += 180
