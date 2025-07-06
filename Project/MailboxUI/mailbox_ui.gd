extends Control

@export var letter_buttons: Array[TextureButton] = []
@export_file("*.txt") var text_path: Array[String]

@export var letter_rtl: RichTextLabel

@export var mailbox_ui: Control
@export var letter_ui: Control
 
func _on_button_pressed() -> void:
	get_parent().visible = false
	_on_page_close_pressed()

func _ready() -> void:
	_on_page_close_pressed()
	for button in letter_buttons:
		var index = letter_buttons.find(button)
		if index != -1:
			button.pressed.connect(_on_letter_button_pressed.bind(index))
	# Connect signals from DialogueGlobals to handle letter visibility
	DialogueGlobals.invitation_found_changed.connect(_on_flag_changed.bind(0)) # Bird
	DialogueGlobals.intronote_found_changed.connect(_on_flag_changed.bind(1)) # tree page
	DialogueGlobals.tokenintro_found_changed.connect(_on_flag_changed.bind(2)) # raccon guy
	# Initialize letter button visibility on start
	_on_flag_changed(DialogueGlobals.invitation_found, 0)
	_on_flag_changed(DialogueGlobals.intronote_found, 1)
	_on_flag_changed(DialogueGlobals.tokenintro_found, 2)


func _on_letter_button_pressed(index: int) -> void:
	var file = FileAccess.open(text_path[index], FileAccess.READ)
	var letter_text = file.get_as_text()
	file.close()
	letter_rtl.text = letter_text
	letter_ui.visible = true
	mailbox_ui.visible = false
	# Do something with the letter button

func _on_page_close_pressed() -> void:
	letter_ui.visible = false
	mailbox_ui.visible = true
	



# Handles updates to letter visibility based on DialogueGlobals flags
func _on_flag_changed(found: bool, index: int) -> void:
	if index >= 0 and index < letter_buttons.size():
		letter_buttons[index].visible = found
