extends Enemy
class_name Mechorilla

@onready var sm : MRStateMachine = %stateMachine
@onready var a : AnimationPlayer = %anim

func _physics_process(delta: float) -> void:
	%"MecharillaEnemy-sheet".flip_h = velocity.x > 0
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func hurt(attack_position : Vector2) ->void:
	for n in %sfx.get_children():
		if n is AudioStreamPlayer:
			n.pitch_scale += randf_range(-.1, .1)
	
	g.camera.screen_shake(5, 0.2)
	g.frame_freeze(0.5, 0.2)
	
	%anim.play("death")
	sm.change_state("dead")
	
	var knock_dir : Vector2 = (global_position - attack_position).normalized()
	velocity = knock_dir * 1000
	%hitfx.look_at(to_global(global_position.direction_to(attack_position)))
	%hitfx.rotation_degrees += 180

func shake()-> void:
	g.camera.screen_shake(5, 0.2)

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("hurt"):
		area.get_parent().hurt(global_position)

var boulder_scn : PackedScene = preload("res://projectiles/boulder/boulder.tscn")
func spawn_boulder() -> void:
	var boulder : Boulder = boulder_scn.instantiate()
	g.projectile_container.add_child(boulder)
	boulder.global_position = global_position
	boulder.parent = self
	boulder.velocity.x = global_position.direction_to(g.player.global_position).x * boulder.speed
