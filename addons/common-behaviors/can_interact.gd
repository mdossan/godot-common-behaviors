class_name CanInteract
extends Area2D

var can_interact = false
var interactables: Array[CanInteract] = []

func _on_area_entered(area: Area2D) -> void:
	can_interact = true
	if area is CanInteract:
		interactables.push_back(area)

func _on_area_exited(area: Area2D) -> void:
	can_interact = false
	interactables = interactables.filter(func(e): return e != area)

func _process(_delta: float):
	if Input.is_action_just_pressed("interact") and len(interactables) >= 1:
		var last_interactable = interactables[-1]
		last_interactable.interract(self)
