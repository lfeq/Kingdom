## PlayerSecondAttack.gd
## This script defines the PlayerAttackState class, which extends IState. 
## It represents the attacking state of the player.

extends IState

## The state to transition to when the attack animation is finished.
@export var idleState: IState

## Reference to the collision shape to disable after use.
@onready var frontAttackCollider = $"../../AttackCollider/CollisionShape2D"
## Reference to the position of the Area2D, to be changed depending 
## on the direction of the player (Attack upwards, downward, etc...).
@onready var attackCollider = $"../../AttackCollider"
## Reference to the player.
@onready var player = $"../.."

## Called when the state is entered.
## Can be extended to add custom logic for entering the attack state.
func enter() -> void:
	if player.lastLookAtDirection.y < 0:
		player.animatedSprite.play("Attack_Up2")
		attackCollider.position = Vector2(0, -48)
	elif player.lastLookAtDirection.y > 0:
		player.animatedSprite.play("Attack_Down2")
		attackCollider.position = Vector2(0, 32)
	elif player.lastLookAtDirection.x > 0:
		player.animatedSprite.play("Attack_Side2")
		attackCollider.position = Vector2(64, 0)
	elif player.lastLookAtDirection.x < 0:
		player.animatedSprite.play("Attack_Side2")
		attackCollider.position = Vector2(-64, 0)
	frontAttackCollider.disabled = false

## Processes frame updates specific to the attacking state.
## Transitions to idleState if the attack animation is no longer playing.
## Returns the new state if a transition occurs, otherwise returns null.
func processFrame(delta: float) -> IState:
	if player.animatedSprite.is_playing():
		return null
	return idleState

## Called when the state is exited.
## Disables the front attack collider.
func exit() -> void:
	frontAttackCollider.disabled = true
