## PlayerIdleState.gd
## This script defines the PlayerIdleState class, which extends IState. 
## It represents the idle state of the player.

extends IState

## The state to transition to when a move action is detected.
@export var moveState: IState
## The state to transition to when an attack action is detected.
@export var attackState: IState

## Reference to the player
@onready var player = $"../.."

## Called when the state is entered.
## Resets the player's velocity to 0.
func enter() -> void:
	player.animatedSprite.play(animationName)
	player.velocity = Vector2(0, 0)
	
## Processes input events specific to the idle state.
## Transitions to the moveState if the "move" action is just pressed.
## Returns the new state if a transition occurs, otherwise stays in the current state.
func processInput(event: InputEvent) -> IState:
	if Input.is_action_pressed("move"):
		return moveState
	if Input.is_action_just_pressed("Attack"):
		return attackState
	return null
