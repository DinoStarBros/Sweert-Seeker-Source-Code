extends CharacterBody2D
class_name Player

@onready var anim : AnimationPlayer = %anim
@onready var sm : StateMachinePlayer = %stateMachine

const jump_velocity : float = 600

var coyote_time : float = 0

var dir_to_mouse : Vector2 
func _ready() -> void:
	g.gem_fragments_collected.clear()
	g.player = self
	
	g.player_max_hp = 4
	g.player_hp = g.player_max_hp
	
	await get_tree().create_timer(0.2).timeout
	match g.leveL_music_idx:
		0:
			%tutorial.play()
		1:
			%lvl1.play()
		2:
			%lvl2.play()
		3:
			%lvl3.play()

const terminal_velocity_fall : int = 1500
var enable_gravity : bool = true
var x_dir : int = 1
func _physics_process(delta: float) -> void:
	#print( %mousesprites.position )
	%mousesprites.flip_h = x_dir == -1
	if Input.is_action_just_pressed("Right"):
		x_dir = 1
	elif Input.is_action_just_pressed("Left"):
		x_dir = -1
	
	move_and_slide()
	if not is_on_floor():
		if enable_gravity:
			coyote_time += delta
			if velocity.y >= 40:
				velocity.y += g.gravity * delta * 2
			else:
				velocity.y += g.gravity * delta 
			
			if velocity.y >= terminal_velocity_fall:
				velocity.y = terminal_velocity_fall
	else:
		coyote_time = 0
		slashes_in_air = 0
	
	head_nudge_handling()
	
	#%state_txt.text = str(enable_gravity)
	#%state_txt.text = str(sm.current_state.name)
	#%state_txt.text = str(slashes_in_air)
	#%state_txt.text = str(is_on_wall() or %left_uncling.is_colliding())
	%state_txt.text = str(g.player_hp," / ", g.player_max_hp)
	
	dir_to_mouse = (get_global_mouse_position() - global_position).normalized()
	
	if g.player_hp <= 0:
		sm.change_state("dead")
	
	%"Healthcircle-sheet".frame = g.player_hp

const max_speed : float = 700
const acceleration : float = 20
const friction : float = 10

var x_input: float
var velocity_weight: float

func head_nudge_handling()->void:
	#print(sm.current_state.name)
	
	if velocity.y < -jump_velocity / 2:
		var head_collision: Array = [
			%left_hn.is_colliding(), %left_hn2.is_colliding(), %right_hn.is_colliding(), %right_hn2.is_colliding()
		]
		if head_collision.count(true) == 1:
			if head_collision[0]:
				global_position.x += 12
			if head_collision[3]:
				global_position.x -= 12

const dash_velocity: float = 700
var slashes_in_air : float = 0
var wallcling_direction : int

var time_hook_out : float = 0


func _on_slash_pivot_body_entered(body: Enemy) -> void:
	if body is Enemy:
		body.hurt(global_position)

@onready var grapple_controller : GrappleController = %grapple_controller

func hurt(_attack_pos : Vector2) -> void:
	g.camera.screen_shake(10, 0.5)
	g.frame_freeze(.3, .5)
	
	g.player_hp -= 1
	
	if g.player_hp <= 0:
		sm.change_state("dead")
	else:
		%ouchnim.play("ouch")

func insta_kill() -> void:
	g.camera.screen_shake(10, 0.5)
	g.frame_freeze(.3, .5)
	g.player_hp = 0

func _on_slash_pivot_area_entered(area: Area2D) -> void:
	if area is Projectile:
		g.camera.screen_shake(7, 0.5)
		g.frame_freeze(.5, .25)
		
		area.reflect(global_position)
		
	if area is CompleteGem or area is GemFragment:
		area.collect()

func shake() -> void:
	g.camera.screen_shake(10, 0.5)

var checkpoint : Node2D

func _init() -> void:
	GlobalSignals.connect("Start_Escape", escape_start)

func escape_start() -> void:
	for n in %music.get_children():
		if n is AudioStreamPlayer:
			n.stop()
	
	%escape.play()

var is_vulnerable : bool = false
func vulnerable()-> void:
	is_vulnerable = true

func invulnerable()-> void:
	is_vulnerable = false
