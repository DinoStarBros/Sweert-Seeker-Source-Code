extends Control

var time : float = 0
var minutes:float=0
var seconds:float=0
var ms:float=0

var time_full : String
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	visible = g.escape
	if g.escape and not get_tree().paused:
		time -= delta
	
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	ms = fmod(time, 1) * 100
	
	%Min.text = "%02d:" % minutes
	%Sec.text = "%02d." % seconds
	%MSec.text = "%03d" % ms
	time_full = str("%02d:" % minutes, "%02d." % seconds, "%04d" % ms)
	
	if time <= 0 and g.escape and not g.times_up:
		g.times_up = true
		GlobalSignals.emit_signal("Times_Up")

func _init() -> void:
	GlobalSignals.connect("Times_Up", times_up)
	GlobalSignals.connect("Start_Escape", escape_start)

func times_up() -> void:
	get_tree().change_scene_to_file("res://screens/game_over/game_over.tscn")

func escape_start() -> void:
	time = g.escape_time
