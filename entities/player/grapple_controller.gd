extends Node2D
class_name GrappleController

@export var rest_length : float = 2.0
@export var stiffness : float = 10.0
@export var damping : float = .2

@onready var player : Player = get_parent()
@onready var ray : RayCast2D = %RayCast2D
@onready var rope : Line2D = %Line2D

var launched : bool = false
var target: Vector2

var swing_mode : String = "swing" # swing, enemyHook, zipline
var space_pressed : bool = false

func _ready() -> void:
	%blue.set_point_position(1, Vector2(%RayCast2D.target_position.x - 10, 0))

func _process(delta: float) -> void:
	%auto_aim_area.look_at(get_global_mouse_position())
	#%is_behind_wall_ene.look_at(get_global_mouse_position())
	
	var is_behind_wall_enemy : bool = %is_behind_wall_ene.get_collider() is TileMapLayer
	if %auto_aim_area.get_overlapping_bodies().size() > 0:# and not is_behind_wall_enemy:
		#%ray_pivot.look_at(%auto_aim_area.get_overlapping_bodies()[0].global_position)
		%is_behind_wall_ene.look_at(%auto_aim_area.get_overlapping_bodies()[0].global_position)
		if is_behind_wall_enemy:
			%ray_pivot.look_at(get_global_mouse_position())
		else:
			%ray_pivot.look_at(%auto_aim_area.get_overlapping_bodies()[0].global_position)
	else:
		%ray_pivot.look_at(get_global_mouse_position())
		%is_behind_wall_ene.look_at(get_global_mouse_position())
	
	%blue.rotation_degrees = %ray_pivot.rotation_degrees
	
	if Input.is_action_just_pressed("Grapple") and player.sm.current_state.name != "dead" and player.sm.current_state.name != "portalSlurp" and player.sm.current_state.name != "portalEnter":
		launch()
	if not Input.is_action_pressed("Grapple"): #and swinging:
		retract()
	
	if launched:
		swing(delta)

var grapple_dashed : bool = false
var x_dir : int

var raycast_collider : Node2D
func launch()-> void:
	if ray.is_colliding():
		show()
		grapple_dashed = false
		launched = true
		target = ray.get_collision_point()
		rope.show()
		initial_radius = global_position.distance_to(target)
		player.sm.change_state("hook")
		
		space_pressed = false
		
		raycast_collider = %RayCast2D.get_collider()
		if raycast_collider is Enemy:
			swing_mode = "enemyHook"
		else:
			swing_mode = "swing"
		
		if radius.normalized().x > 0:
			x_dir = -1
		else:
			x_dir = 1

func retract()-> void:
	launched = false
	
	rope.hide()
	if player.sm.current_state.name == "hook":
		if player.is_on_floor():
			player.sm.change_state("walk")
		else:
			player.sm.change_state("hookJump")
	
	if %ouchnim.current_animation != "ouch":
		%hurcol.disabled = false

func update_rope()-> void:
	rope.set_point_position(1, to_local(target))

var initial_radius : float
var current_radius : float 
var radius : Vector2

func swing(_delta:float)-> void:
	
	radius = global_position - target
	if player.velocity.length() < 0.01 or radius.length() < 10: 
		return
	
	var angle = acos(radius.dot(player.velocity) / (radius.length() * player.velocity.length()))
	var rad_vel : float = cos(angle) * player.velocity.length()
	
	current_radius = global_position.distance_to(target)
	
	if player.sm.current_state.name == "hook":
		
		if swing_mode == "swing":
			
			if Input.is_action_just_pressed("Jump"):
				space_pressed = true
				
			if space_pressed:
				player.velocity = player.global_position.direction_to(target) * 5000
				if player.is_on_floor() or player.is_on_wall() or player.is_on_ceiling():
					if global_position.distance_to(target) <= 50:
						player.velocity = Vector2.ZERO
			else:
				if player.is_on_floor():
					player.velocity += player.global_position.direction_to(target) * 30
				else:
					player.velocity += (radius.normalized() * -rad_vel)
				
		
		elif swing_mode == "enemyHook": 
			# This means hooked onto an enemy, it'll send the player towards the enemy
			
			if %hookHitRadius.get_overlapping_bodies().size() > 0: # The player has hit the enemy
				update_rope()
				player.velocity = Vector2.ZERO
				player.sm.change_state("enemyHooked")
				%hurcol.disabled = false
				hide()
				
			elif player.sm.current_state.name == "hook" and raycast_collider:
				# Dash toward the enemy when the hook hits, 
				# When the player hasn't collided with the enemy yet
				
				#player.global_position = player.grapple_controller.raycast_collider.global_position + Vector2(-30 * x_dir, -30)
				%hurcol.disabled = true
				player.velocity = player.global_position.direction_to(raycast_collider.global_position) * 3000
				show()
				#player.velocity = player.global_position.direction_to(target) * 3000
		
		elif swing_mode == "zipline":
			# Hooked onto a zipline
			pass
	
	if Input.is_action_pressed("Left"):
		x_dir = -1
	elif Input.is_action_pressed("Right"):
		x_dir = 1
	
	if Input.is_action_just_pressed("Grapple Boost") and not player.is_on_floor():
		if not grapple_dashed:
			player.anim.play("grappleBoost")
			%ouchnim.play("short_iframes")
			
			grapple_dashed = true
			player.velocity.x = 2000 * x_dir
	
	const lim_vel_x : float = 3
	if player.velocity.x > player.max_speed * lim_vel_x:
		player.velocity.x = player.max_speed * lim_vel_x
	if player.velocity.x < -player.max_speed * lim_vel_x:
		player.velocity.x = -player.max_speed * lim_vel_x
	
	const lim_vel_y : float = -700
	if player.velocity.y < lim_vel_y:
		player.velocity.y = lim_vel_y
	
	update_rope()
