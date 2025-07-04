extends TextureButton

@export var mailbox_UI_scene: PackedScene

func _pressed():
	if mailbox_UI_scene:
		var canvas_layer = CanvasLayer.new()
		var mailbox_ui_instance = mailbox_UI_scene.instantiate()
		canvas_layer.add_child(mailbox_ui_instance)
		get_parent().add_child(canvas_layer)

func _ready():
	pressed.connect(_pressed)
