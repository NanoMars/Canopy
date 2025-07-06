extends Node

var intronote_found = false
var invitation_found = false
var tokenintro_found = false
var photo_found = false

var bird_interacted = false


func _ready() -> void:
	_load()


func _process(delta: float) -> void:
	print(intronote_found)

func open_chest():
	get_tree().get_first_node_in_group("openclose").open()
	#$Control/Node/tokenchest/openclose.open()
	#$Control/Node/tokenchest/closed.hide()
	#$Control/Node/tokenchest/open.show()

const save_location = "user://savefile.json"

var staff_guys: Array = []
var npc_info: Array = []

var save_data: Dictionary = {
	"intronote_found": false,
	"invitation_found": false,
	"tokenintro_found": false,
	"photo_found": false,
	"bird_interacted": false,
}

func _exit_tree() -> void:
	_save()


func _save():
	save_data.intronote_found = intronote_found
	save_data.invitation_found = invitation_found
	save_data.tokenintro_found = tokenintro_found
	save_data.photo_found = photo_found
	save_data.bird_interacted = bird_interacted
	
	var savefile = FileAccess.open(save_location, FileAccess.WRITE)
	savefile.store_var(save_data.duplicate())
	savefile.close()

func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var loaded_save_data = data.duplicate()
		intronote_found = loaded_save_data.intronote_found
		tokenintro_found = loaded_save_data.tokenintro_found
		invitation_found = loaded_save_data.invitation_found
		photo_found = loaded_save_data.photo_found
		bird_interacted = loaded_save_data.bird_interacted
