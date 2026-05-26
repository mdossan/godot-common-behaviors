extends Node3D

func rotate_interaction(actor: Node):
	print("%s asked for rotation" % actor)
	rotate_y(deg_to_rad(10))
