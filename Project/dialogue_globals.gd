extends Node

var intronote_found: bool:
	set(value):
		if value != _intronote_found:
			_intronote_found = value
			intronote_found_changed.emit(value)
	get():
		return _intronote_found

var invitation_found: bool:
	set(value):
		if value != _invitation_found:
			_invitation_found = value
			invitation_found_changed.emit(value)
	get():
		return _invitation_found

var tokenintro_found: bool:
	set(value):
		if value != _tokenintro_found:
			_tokenintro_found = value
			tokenintro_found_changed.emit(value)
	get():
		return _tokenintro_found
var photo_found: bool:
	set(value):
		if value != _photo_found:
			_photo_found = value
			photo_found_changed.emit(value)
	get():
		return _photo_found

var _intronote_found = false
var _invitation_found = false
var _tokenintro_found = false
var _photo_found = false

signal invitation_found_changed(found: bool)
signal intronote_found_changed(found: bool)
signal tokenintro_found_changed(found: bool)
signal photo_found_changed(found: bool)

var bird_interacted = false


func _ready() -> void:
	_load()

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
		# intronote_found = false
		# tokenintro_found = false
		# invitation_found = false
		# photo_found = false
		# bird_interacted = false
