extends Node
class_name SentryStateMachine

@export var initial_state : String
@export var state_text : Label

var current_state : StateSentry
var previous_state : StateSentry

func _ready()-> void:
	current_state = find_child(initial_state) as StateSentry
	previous_state = current_state
	current_state.enter()

func _process(_delta:float)-> void:
	if state_text:
		state_text.text = str(current_state.name)

func change_state(state: String)-> void:
	
	current_state = find_child(state) as StateSentry
	
	if previous_state.name != current_state.name:
		current_state.enter()
	
	if previous_state.name != current_state.name:
		previous_state.exit()
	
	previous_state = current_state
