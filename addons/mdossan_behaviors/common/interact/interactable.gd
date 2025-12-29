class_name Interactable
extends Area2D

var can_interact = false
signal interacted(interact_behaviour: CanInteract)

func interract(source: CanInteract):
	if can_interact:
		interacted.emit(source)

func _on_area_entered(_area: Area2D) -> void:
	can_interact = true

func _on_area_exited(_area: Area2D) -> void:
	can_interact = false
