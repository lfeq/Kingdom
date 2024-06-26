## PlayerIdleState.gd
## This script defines the PlayerIdleState class, which extends IState. It represents the idle state of the player.

extends IState

## The state to transition to when a move action is detected.
@export var moveState: IState
@export var attackState: IState

## Called when the state is entered.
## Resets the player's horizontal velocity to 0.
func enter() -> void:
	super()
	parent.velocity.x = 0
	
## Processes input events specific to the idle state.
## Transitions to the moveState if the "move" action is just pressed.
## Returns the new state if a transition occurs, otherwise returns null.
func processInput(event: InputEvent) -> IState:
	if Input.is_action_pressed("move"):
		return moveState
	if Input.is_action_just_pressed("Attack"):
		return attackState
	return null
