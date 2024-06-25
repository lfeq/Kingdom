extends IState

@export var moveState: IState

func enter() -> void:
	super()
	parent.velocity.x = 0
	
func processInput(event: InputEvent) -> IState:
	if Input.is_action_just_pressed("move"):
		return moveState
	return null
