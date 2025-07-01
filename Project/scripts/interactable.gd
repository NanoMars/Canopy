extends Area2D
class_name interactable

#here we can set up button noises and cursor effects
func _ready() -> void:
	input_pickable = true

func _mouse_enter() -> void:
	print("mouse_enter")

func _mouse_exit() -> void:
	print("mouse_exit")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		left_clicked()
		

func left_clicked() -> void:
	#print("left_click ) (interacted)")
	if get_child_count() != 0:
		#get_child().interacted()
		for i in get_children():
			if i.is_in_group("interactable"):
				i.interacted()
