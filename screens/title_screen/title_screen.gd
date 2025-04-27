extends Node2D

func _ready() -> void:
	SceneManager.fade_in()

func _on_play_pressed() -> void:
	g.scene_change("res://screens/level_select/level_select.tscn")

func _on_about_pressed() -> void:
	%about.show()

func _on_settings_pressed() -> void:
	%settingsMenu.show()

func _on_credits_pressed() -> void:
	%credits.show()

func _on_quit_pressed() -> void:
	get_tree().quit()

var sin_val : float = 0
func _physics_process(delta: float) -> void:
	sin_val += delta
	if sin_val >= 180:
		sin_val = 0
	
	%Sweeker.position.y += sin(sin_val) * 20 * delta
	%SweekerDrone.position.y += sin(sin_val) * -20 * delta
