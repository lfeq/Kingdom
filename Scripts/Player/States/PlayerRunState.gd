## PlayerRunState.gd
## This script defines the PlayerRunState class, which extends IState. It represents the running state of the player.

extends IState

## The state to transition to when the player stops moving.
@export var idleState: IState
## The state to transition to when the player initiates an attack.
@export var attackState: IState

## Reference to the player.
@onready var player = $"../.."

## The movement speed of the player in the running state.
var movementSpeed: float = 400

## Called when the state is entered.
## Sets the movement speed to the parent's maximum movement speed.
func enter() -> void:
	player.animatedSprite.play(animationName)
	movementSpeed = player.maxMovementSpeed
	
## Processes input events specific to the running state.
## Transitions to attackState if the "Attack" action is just pressed.
## Returns the new state if a transition occurs, otherwise returns null.
func processInput(event: InputEvent) -> IState:
	if Input.is_action_just_pressed("Attack"):
		return attackState
	return null

## Processes physics updates specific to the running state.
## Handles player movement based on input and transitions to idleState if no movement input is detected.
## Returns the new state if a transition occurs, otherwise returns null.
func processPhysics(delta: float) -> IState:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction != Vector2.ZERO:
		player.lastLookAtDirection = direction
	if direction == Vector2.ZERO:
		return idleState
	player.velocity = direction * movementSpeed
	player.animatedSprite.flip_h = direction.x < 0 # Rotate player
	player.move_and_slide()
	return null
