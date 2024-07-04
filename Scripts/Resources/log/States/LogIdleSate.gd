## LogIdleState.gd

extends IState

## Reference to tree.
@onready var log = $"../.."

## Called when the state is entered.
## Plays the damage animation for the tree.
func enter() -> void:
	log.animatedSprite.play(animationName)
