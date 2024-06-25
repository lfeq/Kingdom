class_name StateMachine
extends Node

@export var startingState: IState

var currentState: IState

func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent
	changeState(startingState)

func changeState(t_newState: IState) -> void:
	if currentState == t_newState:
		return
	if currentState:
		currentState.exit()	
	currentState = t_newState
	currentState.enter()
	
func processPhysics(delta: float) -> void:
	var newState = currentState.processPhysics(delta)
	if newState:
		changeState(newState)
	
func processInput(event: InputEvent) -> void:
	var newState = currentState.processInput(event)
	if newState:
		changeState(newState)
		
func processFrame(delta: float) -> void:
	var newState = currentState.processFrame(delta)
	if newState:
		changeState(newState)
