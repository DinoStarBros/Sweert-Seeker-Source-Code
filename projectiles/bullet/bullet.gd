extends Projectile
class_name EneBullet

var velocity : Vector2
const speed : float = 500

var reflected : bool = false
var parent : Enemy

func _ready() -> void:
	%shot2.pitch_scale = randf_range(0.8,1)
	%shot2.play(0.2)
	
	%shot1.pitch_scale = randf_range(0.8,1)
	%shot1.play()

func _process(delta: float) -> void:
	move(delta)

func move(delta:float) -> void:
	global_position += velocity * delta

func _on_area_entered(area: Area2D) -> void:
	
	if not reflected:
		if area.get_parent() is Player and area.name == "hurtbox":
			if area.get_parent().has_method("hurt"):
				area.get_parent().hurt(global_position)


func reflect(attack_pos : Vector2) -> void:
	reflected = true
	var reflect_dir = global_position.direction_to(get_global_mouse_position())
	#global_position.direction_to(attack_pos)
	
	if parent:
		look_at(parent.global_position)
		velocity = global_position.direction_to(parent.global_position) * speed * 2
	else:
		look_at(get_global_mouse_position())
		velocity = reflect_dir * speed * 2
	
	%reflect.pitch_scale = randf_range(0.9, 1.1)
	%reflect.play()

func _on_body_entered(body: Node2D) -> void:
	if body is Enemy and reflected:
		body.hurt(global_position)

func _on_timer_timeout() -> void:
	queue_free()
