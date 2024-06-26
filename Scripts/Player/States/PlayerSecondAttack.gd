## PlayerSecondAttack.gd
## This script defines the PlayerAttackState class, which extends IState. It represents the attacking state of the player.

extends IState

## The state to transition to when the attack animation is finished.
@export var idleState: IState

## Called when the state is entered.
## Can be extended to add custom logic for entering the attack state.
func enter() -> void:
	super()

## Processes frame updates specific to the attacking state.
## Transitions to idleState if the attack animation is no longer playing.
## Returns the new state if a transition occurs, otherwise returns null.
func processFrame(delta: float) -> IState:
	if parent.animatedSprite.is_playing():
		return null
	return idleState
