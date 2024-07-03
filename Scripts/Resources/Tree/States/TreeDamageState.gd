# TreeDamageState.gd
## This script defines the TreeDamageState class, which extends IState. It represents the damage state of a tree.

extends IState

## The state to transition to when the damage animation is finished.
@export var idleState: IState

## Called when the state is entered.
## Plays the damage animation for the tree.
func enter() -> void:
	$"../../AnimatedSprite2D".play("Damage")

## Processes frame updates specific to the damage state.
## Transitions to idleState when the damage animation finishes.
## Returns the new state if a transition occurs, otherwise returns null.
func processFrame(delta: float) -> IState:
	if $"../../AnimatedSprite2D".is_playing():
		return null
	return idleState
