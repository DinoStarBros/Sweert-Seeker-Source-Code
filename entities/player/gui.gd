extends CanvasLayer

@onready var anim : AnimationPlayer = %screen_anims
@onready var fragment_sprites : Array[Sprite2D] = [
	%"0",
	%"1",
	%"2",
	%"3"
]

func _ready() -> void:
	for n in fragment_sprites:
		n.hide()

func _init() -> void:
	GlobalSignals.connect("Reset_Room", reset_room)

func reset_room() -> void:
	await get_tree().create_timer(0.5).timeout
	anim.play("in&out")

var sin_val : float = 0
func _process(delta: float) -> void:
	for n in g.gem_fragments_collected:
		fragment_sprites[n].show()
	
	sin_val += delta * 2
	if sin_val >= 180:
		sin_val = 0
	%fragments.position.y += sin(sin_val) * 10 * delta
	
	if Input.is_action_just_pressed("Esc"):
		_on_pause_pressed()
	
	%pause_stuff.visible = get_tree().paused
	%settingsMenu.visible = get_tree().paused
	%sure.visible = get_tree().paused and are_you_sure

func player_goto_checkpoint() -> void:
	GlobalSignals.emit_signal("Player_Goto_Checkpoint")

func _on_pause_pressed() -> void: ## The general function used for pausing
	if get_tree().paused:
		%settingsMenu._on_save_pressed()
	else:
		%settingsMenu._on_load_pressed()

	get_tree().paused = not get_tree().paused
	are_you_sure = false

var are_you_sure : bool = false
func _on_quit_pressed() -> void:
	are_you_sure = not are_you_sure

func _on_yes_pressed() -> void:
	get_tree().paused = false
	g.scene_change("res://screens/level_select/level_select.tscn")

func _on_no_pressed() -> void:
	are_you_sure = false
