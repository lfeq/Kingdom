## LogSpawnState.gd

extends IState

## The state to transition to when the damage animation is finished.
@export var idleState: IState

## Reference to tree.
@onready var log = $"../.."

## Called when the state is entered.
## Plays the damage animation for the tree.
func enter() -> void:
	log.animatedSprite.play(animationName)

## Processes frame updates specific to the damage state.
## Transitions to idleState when the damage animation finishes.
## Returns the new state if a transition occurs, 
## otherwise stays in the current state.
func processFrame(delta: float) -> IState:
	if log.animatedSprite.is_playing():
		return null
	return idleState
