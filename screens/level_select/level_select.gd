extends Node2D


func _on_tut_pressed() -> void:
	g.scene_change("res://screens/prototype_scene/prototype_scene.tscn")

func _on_lv_1_pressed() -> void:
	g.scene_change("res://screens/level1/level_1.tscn")

func _on_lv_2_pressed() -> void:
	g.scene_change("res://screens/level2/level_2.tscn")

func _on_back_pressed() -> void:
	g.scene_change("res://screens/title_screen/title_screen.tscn")
