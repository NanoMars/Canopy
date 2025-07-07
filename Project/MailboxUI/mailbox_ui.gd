extends Control

@export var letter_buttons: Array[TextureButton] = []
@export var text_content: Array[String] = [
	"CANOPY is a game-focused week full of fun workshops, game creation, and new friends. We’re running three events: Intro to Godot, Workshop Day (3D assets in Blender + Intro to Godot UI), and a Group Game Jam. Attend any of these Canopy events and you’ll earn free-use stipends to spend however you like next week.",
	"If you are receiving this, it means you are invited to the first event of canopy. But what is such a prestigious event even about?\n\nThis is an in-person event where you will create a platformer in Godot. If you're new to the engine then it will be the perfect introduction, and if you're experienced, it will be a fun opportunity to see how far you can push the idea of a platformer. It's taking place In two locations, we will start at the 55 and second coworking space, and move to the salesforce park for dinner. It will last 8 hours, going from 10am to 6pm. There will be lunch and dinner provided at no cost, and there will be three tokens given out to each person who stays the whole duration.\n\nClimb this branch to get one step closer to the Canopy, we hope to see you there!\n\nsign up: https://forms.hackclub.com/t/u4CsZYUathus",
	"Free-use stipends let you spend your tokens on anything you like—meals, attractions, travel, or whatever you choose. You earn them as physical wooden tokens by joining Canopy events all week. Each token is worth $5 in stipend cash. At the end of the week, simply turn in your tokens to claim your stipend and spend it however you want."
]

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
	var letter_text = text_content[index]
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
