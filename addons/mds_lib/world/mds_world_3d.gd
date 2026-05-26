class_name MdsWord3D
extends Node3D

@rpc("any_peer", "call_local")
func spawn_item(resource: String, position: Vector3):
	%MdsNode3DSpawner.spawn({
		"multiplayer_authority": multiplayer.get_unique_id(),
		"resource_path": resource,
		"position": position,
	})
