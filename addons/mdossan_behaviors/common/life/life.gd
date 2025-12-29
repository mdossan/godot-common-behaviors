class_name Life extends Node

@export var INITIAL_LIFE: int = 3

signal has_taken_damage(remaining_life: int)
signal has_died

var life: int = INITIAL_LIFE

func take_damage():
	life -= 1
	if life == 0:
		has_died.emit()
	else:
		has_taken_damage.emit(life)
