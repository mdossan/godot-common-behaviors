extends Node3D

@export var spawn_peer_id: int = 42

func spawn_item(item_id: String):
	%MdsItem3DSpawner.spawn(item_id)
