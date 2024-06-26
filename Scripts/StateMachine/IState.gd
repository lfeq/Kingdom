## IState.gd
## This script defines the IState class, which extends Node. It represents a state in the player's state machine.

class_name IState
extends Node

## The name of the animation to play when this state is entered.
@export var animationName: String

## Reference to the parent Player instance.
var parent: Player

## Called when the state is entered.
## Plays the specified animation on the player's animated sprite.
func enter() -> void:
	parent.animatedSprite.play(animationName)
	
## Called when the state is exited.
## Can be overridden to add custom exit logic.
func exit() -> void:
	pass
	
## Processes input events.
## This method should be overridden to handle input specific to the state.
## Returns the next state based on the input event, or null if the state doesn't change.
func processInput(event: InputEvent) -> IState:
	return null
	
## Processes frame updates.
## This method should be overridden to handle frame-based logic specific to the state.
## Returns the next state based on frame logic, or null if the state doesn't change.
func processFrame(delta: float) -> IState:
	return null
	
## Processes physics updates.
## This method should be overridden to handle physics-based logic specific to the state.
## Returns the next state based on physics logic, or null if the state doesn't change.
func processPhysics(delta: float) -> IState:
	return null
