# TreeDeathState.gd
## This script defines the TreeDeathState class, which extends IState. 
## It represents the death state of a tree.

extends IState

## Called when the state is entered.
## Plays the idle animation for the tree.
func enter() -> void:
	$"../../AnimatedSprite2D".play("Death")
