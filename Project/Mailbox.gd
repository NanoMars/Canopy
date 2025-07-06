extends TextureButton

@export var mailbox_UI_scene: PackedScene
@onready var unprocessed_texture = texture_normal
var unprocessed_bitmap: BitMap = BitMap.new()
var mailbox_ui_instance: CanvasLayer


func _pressed():
	if mailbox_UI_scene and not mailbox_ui_instance:
		mailbox_ui_instance = mailbox_UI_scene.instantiate()
		get_parent().add_child(mailbox_ui_instance)
	elif mailbox_ui_instance:
		mailbox_ui_instance.visible = true

func _ready():
	pressed.connect(_pressed)
	unprocessed_bitmap.create_from_image_alpha(unprocessed_texture.get_image(), 0.1)
	texture_click_mask = unprocessed_bitmap
