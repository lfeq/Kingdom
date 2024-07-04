## PlayerAttackState.gd
## This script defines the PlayerAttackState class, which extends IState. 
## It represents the attacking state of the player.

extends IState

## The state to transition to when the attack animation is finished.
@export var idleState: IState
## The state to transition to for a second attack.
@export var secondAttackState: IState

## Flag indicating whether a second attack should be performed.
var shouldSecondAttack: bool = false

## Reference to the collision shape to disable after use.
@onready var frontAttackCollider = $"../../AttackCollider/CollisionShape2D"
## Reference to the position of the Area2D, to be changed depending 
## on the direction of the player (Attack upwards, downward, etc...).
@onready var attackCollider = $"../../AttackCollider"
## Reference to the player.
@onready var player = $"../.."

## Called when the state is entered.
## Initializes the second attack flag and can be extended to add custom logic for entering the attack state.
func enter() -> void:
	if player.lastLookAtDirection.y < 0:
		player.animatedSprite.play("Attack_Up")
		attackCollider.position = Vector2(0, -48)
	elif player.lastLookAtDirection.y > 0:
		player.animatedSprite.play("Attack_Down")
		attackCollider.position = Vector2(0, 32)
	elif player.lastLookAtDirection.x > 0:
		player.animatedSprite.play("Attack_Side")
		attackCollider.position = Vector2(64, 0)
	elif player.lastLookAtDirection.x < 0:
		player.animatedSprite.play("Attack_Side")
		attackCollider.position = Vector2(-64, 0)
	frontAttackCollider.disabled = false
	shouldSecondAttack = false

## Processes frame updates specific to the attacking state.
## Transitions to secondAttackState if the second attack flag is set, otherwise transitions to idleState when the animation finishes.
## Returns the new state if a transition occurs, otherwise returns null.
func processFrame(delta: float) -> IState:
	if player.animatedSprite.is_playing():
		return null
	if shouldSecondAttack:
		return secondAttackState
	return idleState

## Processes input events specific to the attacking state.
## Sets the second attack flag if the "Attack" action is just pressed.
## Returns null as this state does not transition based on input directly.
func processInput(event: InputEvent) -> IState:
	if Input.is_action_just_pressed("Attack"):
		shouldSecondAttack = true
	return null

## Called when the state is exited.
## Disables the front attack collider.
func exit() -> void:
	frontAttackCollider.disabled = true
