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

func _ready() -> void:
	var curve := camera_path.curve
	var point_count := curve.get_point_count()
	if path_follow.loop and point_count > 0:
		var first_pos := curve.get_point_position(0)
		if point_count > 1:
			curve.set_point_position(point_count - 1, first_pos)
		else:
			curve.add_point(first_pos)
		max_progress = curve.get_baked_length()



func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			goal_velocity += scroll_goal_increment
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			goal_velocity -= scroll_goal_increment

	elif event is InputEventPanGesture:
		goal_velocity += -event.delta.y * pan_goal_increment


		
		
	
	
func _process(delta):
	# Update goal based on velocity with drag and optional looping
	goal_velocity *= goal_drag
	goal_velocity = clamp(goal_velocity, -max_goal_velocity, max_goal_velocity)
	goal += goal_velocity * delta

	if path_follow.loop:
		# wrap goal around track length
		goal = fposmod(goal, max_progress)
	else:
		goal = clamp(goal, end_buffer, max_progress - end_buffer)

	var temp_pos = path_follow.progress

	if path_follow.loop:
		# calculate shortest path difference on loop
		var diff = goal - temp_pos
		if diff > max_progress * 0.5:
			diff -= max_progress
		elif diff < -max_progress * 0.5:
			diff += max_progress
		marker_velocity += diff * marker_elasticity
	else:
		marker_velocity += (goal - temp_pos) * marker_elasticity

	marker_velocity *= marker_drag
	temp_pos += marker_velocity * delta

	if path_follow.loop:
		temp_pos = fposmod(temp_pos, max_progress)
	else:
		temp_pos = clamp(temp_pos, end_buffer, max_progress - end_buffer)

	path_follow.progress = temp_pos
	
