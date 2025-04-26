extends Node
class_name DroneStateMachine

@export var initial_state : String
@export var state_text : Label

var current_state : StateDrone
var previous_state : StateDrone

func _ready()-> void:
	current_state = find_child(initial_state) as StateDrone
	previous_state = current_state
	current_state.enter()

func _process(_delta:float)-> void:
	if state_text:
		state_text.text = str(current_state.name)

func change_state(state: String)-> void:
	
	current_state = find_child(state) as StateDrone
	
	if previous_state.name != current_state.name:
		current_state.enter()
	
	if previous_state.name != current_state.name:
		previous_state.exit()
	
	previous_state = current_state
