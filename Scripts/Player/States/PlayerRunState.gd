extends IState

@export var idleState: IState

func enter() -> void:
	super()

func processPhysics(delta: float) -> IState:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction == Vector2.ZERO:
		return idleState
	parent.velocity = direction * movementSpeed
	parent.animatedSprite.flip_h = direction.x < 0
	parent.move_and_slide()
	return null
