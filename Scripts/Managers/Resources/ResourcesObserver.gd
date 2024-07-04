## ResourcesObserver.gd
## This script defines the ResourcesObserver class, which extends CanvasLayer. 
## It manages and displays the player's resources, such as wood and gold.

extends CanvasLayer

## Reference to the wood label.
@onready var wood_label: Label = $PanelContainer/MarginContainer/GridContainer/WoodLabel
## Reference to the gold label.
@onready var gold_label: Label = $PanelContainer/MarginContainer/GridContainer/GoldLabel

## The current amount of wood the player has.
var wood_count: int = 0
## The current amount of gold the player has.
var gold_count: int = 0

## Initializes the resource observer by making it visible,
## setting the initial wood and gold amounts, and connecting the player's wood 
## pickup signal to the addWood function.
func init():
	visible = true
	wood_label.text = str(wood_count)
	gold_label.text = str(gold_count)
	var playerRef = $"..".get_node("Player")
	playerRef.picked_up_wood.connect(addWood)

## Adds the specified amount of wood to the wood count and updates the wood label.
## The default amount to add is 1.
func addWood(amountToAdd: int = 1) -> void:
	wood_count += amountToAdd
	wood_label.text = str(wood_count)

## Subtracts the specified amount of wood from the wood count and updates the wood label.
## The default amount to subtract is 1.
func subtractWood(amountToSubtract: int = 1) -> void:
	wood_count -= amountToSubtract
	wood_label.text = str(wood_count)

## Adds the specified amount of gold to the gold count and updates the gold label.
## The default amount to add is 1.
func addGold(amountToAdd: int = 1) -> void:
	gold_count += amountToAdd
	gold_label.text = str(gold_count)

## Subtracts the specified amount of gold from the gold count and updates the gold label.
## The default amount to subtract is 1.
func subtractGold(amountToSubtract: int = 1) -> void:
	gold_count -= amountToSubtract
	gold_label.text = str(gold_count)
