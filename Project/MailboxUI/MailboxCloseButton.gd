extends Button

func _ready() -> void:
	await get_tree().process_frame
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	print("Mailbox UI closed")
	var parent = get_parent()
	if parent:
		parent.queue_free()
