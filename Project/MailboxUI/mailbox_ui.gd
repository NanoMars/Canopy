extends Control

@export var close_button: Button
func _ready() -> void:
	close_button.pressed.connect(_on_button_pressed)
	print("Mailbox UI ready")

func _on_button_pressed() -> void:
	queue_free()
	print("Mailbox UI closed")
