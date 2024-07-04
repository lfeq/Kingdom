# TreeDamageState.gd
## This script defines the TreeDamageState class, which extends IState. 
## It represents the damage state of a tree.

extends IState

## The state to transition to when the damage animation is finished.
@export var idleState: IState

## Reference to tree.
@onready var tree = $"../.."

## Called when the state is entered.
## Plays the damage animation for the tree.
func enter() -> void:
	tree.animatedSprite.play(animationName)

## Processes frame updates specific to the damage state.
## Transitions to idleState when the damage animation finishes.
## Returns the new state if a transition occurs, 
## otherwise stays in the current state.
func processFrame(delta: float) -> IState:
	if tree.animatedSprite.is_playing():
		return null
	return idleState
