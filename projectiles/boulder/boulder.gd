extends Projectile
class_name Boulder

var velocity : Vector2
const speed : float = 500

var reflected : bool = false
var parent : Enemy

func _ready() -> void:
	velocity.y -= speed * 1.5

func _process(delta: float) -> void:
	if enable_gravity:
		velocity.y += delta * g.gravity
	move(delta)

func move(delta:float) -> void:
	global_position += velocity * delta

func _on_area_entered(area: Area2D) -> void:
	
	if not reflected:
		if area.get_parent() is Player and area.name == "hurtbox":
			if area.get_parent().has_method("hurt"):
				area.get_parent().hurt(global_position)


func reflect(_attack_pos : Vector2) -> void:
	reflected = true
	var reflect_dir = global_position.direction_to(get_global_mouse_position())
	#global_position.direction_to(attack_pos)
	
	#if parent:
	enable_gravity = false
	#velocity = global_position.direction_to(parent.global_position) * speed * 2
	#else:
	velocity = reflect_dir * speed * 2
	
	%reflect.pitch_scale = randf_range(0.65, 0.8)
	%reflect.play()

func _on_body_entered(body: Node2D) -> void:
	if body is Enemy and reflected:
		if body.sm.current_state.name != "hooked":
			body.hurt(global_position)

var enable_gravity : bool = true
func _on_timer_timeout() -> void:
	queue_free()
