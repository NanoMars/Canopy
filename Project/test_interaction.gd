extends Node

var times_interacted = 0

func interacted():
	match times_interacted:
		0:
			print("wow, you clicked the circle!")
		1:
			print("with this acuracy you must have debug features on!")
		2:
			print("let me guess, visible collision shapes?")
		3:
			print("your no fun >:(")
	times_interacted += 1
