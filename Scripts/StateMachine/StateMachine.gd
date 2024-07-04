## StateMachine.gd
## This script defines the StateMachine class, which extends Node. 
## It manages the transitions between different states of the player.

class_name StateMachine
extends Node

## The state to start with when the game begins.
@export var startingState: IState

## The current active state.
var currentState: IState

## Initializes the state machine and enteres the starting state.
func init() -> void:
	changeState(startingState)

## Changes the current state to a new state.
## Calls the exit() method of the current state and the enter() method of the new state.
func changeState(t_newState: IState) -> void:
	if currentState == t_newState:
		return
	if currentState:
		currentState.exit()
	currentState = t_newState
	currentState.enter()
	
## Processes physics updates by delegating to the current state's processPhysics method.
## If a new state is returned, change to the new state.
func processPhysics(delta: float) -> void:
	var newState = currentState.processPhysics(delta)
	if newState:
		changeState(newState)
	
## Processes input events by delegating to the current state's processInput method.
## If a new state is returned, change to the new state.
func processInput(event: InputEvent) -> void:
	var newState = currentState.processInput(event)
	if newState:
		changeState(newState)
		
## Processes frame updates by delegating to the current state's processFrame method.
## If a new state is returned, change to the new state.
func processFrame(delta: float) -> void:
	var newState = currentState.processFrame(delta)
	if newState:
		changeState(newState)
