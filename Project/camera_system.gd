extends Node

@export var camera_marker: PathFollow2D
@export var camera_path: Path2D
@export var scrolling_thing: Control

var progress: float:
	set(value):
		_progress = value
		update_marker_position()
	get:
		return _progress

var _progress: float = 0.0

func _ready():
	if camera_marker and camera_path:
		update_marker_position()
		
func update_marker_position():
	camera_marker.progress_ratio = clamp(progress / 100.0, 0.0, 1.0)