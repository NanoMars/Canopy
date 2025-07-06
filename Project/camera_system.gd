extends Node

@export var path_follow: PathFollow2D
@export var camera_path: Path2D
@onready var max_progress: float = camera_path.curve.get_baked_length()

var goal: float = 260.0
@export var scroll_goal_increment: float = 6
@export var pan_goal_increment: float = 1
var goal_velocity: float = 0.0
@export var goal_drag: float = 0.5
@export var max_goal_velocity: float = 100


var marker_velocity: float = 0.0
@export var marker_elasticity: float = 0.1
@export var marker_drag: float = 0.1
@export var end_buffer: float = 100

# how do I do an export 

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			goal_velocity += scroll_goal_increment
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			goal_velocity -= scroll_goal_increment

	elif event is InputEventPanGesture:
		goal_velocity += -event.delta.y * pan_goal_increment


		
		
	
	
func _process(delta):
	# Update goal based on velocity
	goal_velocity *= goal_drag
	goal_velocity = clamp(goal_velocity, -max_goal_velocity, max_goal_velocity)
	goal += goal_velocity * delta
	

	goal = clamp(goal, end_buffer, max_progress - end_buffer)
	var temp_pos = path_follow.progress


	marker_velocity += (goal - temp_pos) * marker_elasticity
	marker_velocity *= marker_drag
	temp_pos += marker_velocity * delta

	path_follow.progress = temp_pos
	
