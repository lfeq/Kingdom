# TreeIdleState.gd
extends IState

## Called when the state is entered.
func enter() -> void:
	$"../../AnimatedSprite2D".play("Idle")

## Signal when tree got hit
func _on_area_2d_area_entered(area):
	print("Me han golpeado")
