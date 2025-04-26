extends Enemy
class_name Drone

@onready var sm : DroneStateMachine = %droneStateMachine
const speed : float = 200
@onready var a : AnimationPlayer = %anim
func _physics_process(_delta: float) -> void:
	move_and_slide()

func hurt(attack_position : Vector2) ->void:
	for n in %sfx.get_children():
		if n is AudioStreamPlayer:
			n.pitch_scale += randf_range(-.1, .1)
	
	g.camera.screen_shake(5, 0.2)
	g.frame_freeze(0.5, 0.2)
	
	sm.change_state("dead")
	%anim.play("death")
	
	var knock_dir : Vector2 = (global_position - attack_position).normalized()
	velocity = knock_dir * 1000
	%hitfx.look_at(to_global(global_position.direction_to(attack_position)))
	%hitfx.rotation_degrees += 180

var bullet_scn : PackedScene = preload("res://projectiles/bullet/bullet.tscn")
func spawn_bullet() -> void:
	var bullet : EneBullet = bullet_scn.instantiate()
	g.projectile_container.add_child(bullet)
	bullet.global_position = global_position
	bullet.parent = self
	var dir_to_plr : Vector2 = global_position.direction_to(g.player.global_position)
	bullet.look_at(g.player.global_position)
	bullet.velocity = dir_to_plr * bullet_spd
const bullet_spd : float = 700
