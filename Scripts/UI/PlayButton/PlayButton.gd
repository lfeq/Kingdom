# PlayButton.gd
# This script defines the PlayButton class, which extends Node. It manages the play button, updates the loading screen, and emits a signal when the play button is pressed.

extends Node

# Signal emitted when the play button is pressed.
signal pressedPlay

# References to various UI elements.
@onready var play_button_panel = $PlayButtonPanel
@onready var progress_bar = $LoadingScreenPanel/ProgressBar
@onready var progress_bar_label = $LoadingScreenPanel/ProgressBarLabel
@onready var loading_screen_panel = $LoadingScreenPanel

# Updates the value of the progress bar.
# t_newValue: The new value to set for the progress bar.
func updateProgressBar(t_newValue: int) -> void:
	progress_bar.value = t_newValue

# Updates the text of the loading screen label.
# t_newText: The new text to set for the progress bar label.
func updateLoadingScreenLabel(t_newText: String) -> void:
	progress_bar_label.text = t_newText

# Called when the play button is pressed.
# Hides the play button panel, shows the loading screen panel, and emits the pressedPlay signal.
func _on_button_pressed():
	play_button_panel.visible = false
	loading_screen_panel.visible = true
	pressedPlay.emit()
