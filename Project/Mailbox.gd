extends TextureButton

@export var mailbox_UI_scene: PackedScene
@onready var unprocessed_texture = texture_normal
var unprocessed_bitmap: BitMap = BitMap.new()


func _pressed():
	if mailbox_UI_scene:
		var canvas_layer = CanvasLayer.new()
		var mailbox_ui_instance = mailbox_UI_scene.instantiate()
		canvas_layer.add_child(mailbox_ui_instance)
		get_parent().add_child(canvas_layer)

func _ready():
	pressed.connect(_pressed)
	unprocessed_bitmap.create_from_image_alpha(unprocessed_texture.get_image(), 0.1)
	texture_click_mask = unprocessed_bitmap
