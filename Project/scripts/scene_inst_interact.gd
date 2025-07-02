extends Node

@export var scene: PackedScene
@export var parent_node: NodePath

func interacted():
	var new_scene = scene.instantiate()
	#get_tree().get_first_node_in_group("main")'
	#parent_node.add_child(new_scene)
	get_node(parent_node).add_child(new_scene)
