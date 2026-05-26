class_name MdsPickTarget3D extends Area3D

@export var parent: MdsItem3D
@export var shape: Shape3D
@export var auto_pick: bool = false

signal picked()
signal dropped() # TODO: emit drpped when drop

func _ready():
	if shape != null:
		%Shape.shape = shape
	parent.add_to_group("pick_target")

@rpc("any_peer", "call_remote")
func remove_item():
	parent.queue_free()

@rpc("any_peer", "call_local")
func remote_pick(peer_id: int):
	set_multiplayer_authority(peer_id)
	if parent:
		parent.set_multiplayer_authority(peer_id)
	
