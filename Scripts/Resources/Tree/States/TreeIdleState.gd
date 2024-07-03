# TreeIdleState.gd
## This script defines the TreeIdleState class, which extends IState. It represents the idle state of a tree.

extends IState

## The state to transition to when the tree takes damage.
@export var damageState: IState

## Called when the state is entered.
## Plays the idle animation for the tree.
func enter() -> void:
	$"../../AnimatedSprite2D".play("Idle")
