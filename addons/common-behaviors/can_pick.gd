extends Node2D

@export var parent: Node2D
signal has_picked(picked_node: Pickable)

func _on_area_entered(area: Area2D) -> void:
	if area is Pickable:
		area.process_mode = Node.PROCESS_MODE_DISABLED
		has_picked.emit(area)
