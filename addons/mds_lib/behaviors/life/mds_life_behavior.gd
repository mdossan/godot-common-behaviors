class_name MdsLifeBehavior
extends Node

static var meta = "mds_life_behavior"

signal damage_taken(amount: float, remaining_life: float)
signal heal_taken(amount: float, remaining_life: float)
signal dead()

@export var parent: Node
@export var max_life = 100.0
@export var start_life = 100.0

var life = start_life

func _ready() -> void:
	life = start_life
	parent.set_meta(meta, self)

func take_damage(amount_of_damage: float):
	life = max(life - amount_of_damage, 0.0)
	if life <= 0.0:
		dead.emit()
	else:
		damage_taken.emit(amount_of_damage, life)

func heal(amount_to_heal: float):
	life = min(life + amount_to_heal, max_life)
	heal_taken.emit(amount_to_heal, life)
