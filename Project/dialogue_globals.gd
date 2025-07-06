extends Node

var intronote_found = false
var invitation_found = false
var tokenintro_found = false
var photo_found = false

var bird_interacted = false


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func open_chest():
	get_tree().get_first_node_in_group("openclose").open()
	#$Control/Node/tokenchest/openclose.open()
	#$Control/Node/tokenchest/closed.hide()
	#$Control/Node/tokenchest/open.show()
