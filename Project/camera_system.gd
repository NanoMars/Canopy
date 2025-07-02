extends Node

@export var path_follow: PathFollow2D
@export var camera_path: Path2D
@onready var max_progress: float = camera_path.curve.get_baked_length()

var goal: float = 0.0
@export var goal_increment: float = 0.1
@export var scroll_goal_increment: float = 6
@export var pan_goal_increment: float = 1

var marker_velocity: float = 0.0
@export var marker_elasticity: float = 0.1
@export var marker_drag: float = 0.1
@export var end_buffer: float = 100
@export var scroll_curve: Curve
@export var max_difference: float = 20

# how do I do an export 

func _input(event):
	var original_goal = goal
	var temp_goal = goal

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			goal += goal_increment
			goal = clamp(goal, end_buffer, max_progress - end_buffer)
			temp_goal += scroll_goal_increment
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			goal -= goal_increment	
			goal = clamp(goal, end_buffer, max_progress - end_buffer)
			temp_goal -= scroll_goal_increment	
	
	elif event is InputEventPanGesture:
		goal += -event.delta.y * goal_increment
		temp_goal += -event.delta.y * pan_goal_increment

	if temp_goal != original_goal:
		if abs(temp_goal - goal) > max_difference:
			temp_goal = goal + sign(temp_goal - goal) * max_difference
		goal = temp_goal
		goal = clamp(goal, end_buffer, max_progress - end_buffer)
		
	
	
func _process(delta):
	var temp_pos = path_follow.progress


	marker_velocity += (goal - temp_pos) * marker_elasticity
	marker_velocity *= marker_drag
	temp_pos += marker_velocity * delta

	path_follow.progress = temp_pos
	
