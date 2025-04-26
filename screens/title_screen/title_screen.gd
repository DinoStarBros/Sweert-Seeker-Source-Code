extends Node2D

func _ready() -> void:
	pass

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
