extends Node
class_name MRStateMachine

@export var initial_state : String
@export var state_text : Label

var current_state : StateMR
var previous_state : StateMR

func _ready()-> void:
	current_state = find_child(initial_state) as StateMR
	previous_state = current_state
	current_state.enter()

func _process(_delta:float)-> void:
	if state_text:
		state_text.text = str(current_state.name)

func change_state(state: String)-> void:
	
	current_state = find_child(state) as StateMR
	
	if previous_state.name != current_state.name:
		current_state.enter()
	
	if previous_state.name != current_state.name:
		previous_state.exit()
	
	previous_state = current_state
