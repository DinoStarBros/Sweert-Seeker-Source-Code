extends Node
class_name CrabStateMachine

@export var initial_state : String
@export var state_text : Label

var current_state : StateCrab
var previous_state : StateCrab

func _ready()-> void:
	current_state = find_child(initial_state) as StateCrab
	previous_state = current_state
	current_state.enter()

func _process(_delta:float)-> void:
	if state_text:
		state_text.text = str(current_state.name)

func change_state(state: String)-> void:
	
	current_state = find_child(state) as StateCrab
	
	if previous_state.name != current_state.name:
		current_state.enter()
	
	if previous_state.name != current_state.name:
		previous_state.exit()
	
	previous_state = current_state
