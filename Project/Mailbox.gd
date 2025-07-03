extends TextureButton

@export var mailbox_UI_scene: PackedScene

func _pressed():
    if mailbox_UI_scene:
        var mailbox_ui_instance = mailbox_UI_scene.instantiate()
        get_parent().add_child(mailbox_ui_instance)

func _ready():
    pressed.connect(_pressed)
