class_name MdsNode3DSpawner
extends MultiplayerSpawner

func _enter_tree() -> void:
	spawn_function = custom_spawn

func custom_spawn(data: Dictionary):
	var multiplayer_authority: int = data["multiplayer_authority"]
	var resource_path: String = data["resource_path"]
	var position: Vector3 = data["position"]
	var rotation: Vector3 = data["rotation"]
	var properties: Dictionary = data["properties"]
	var scene: PackedScene = load(resource_path)
	var node: Node3D = scene.instantiate()
	node.set_multiplayer_authority(multiplayer_authority)
	node.position = position
	node.rotation = rotation
	for key in properties.keys():
		node[key] = properties[key]
	return node

var callables: Dictionary[String, Callable] = {
	"drop_item": func(node: Node3D):
		if !is_instance_valid(node):
			return
		var new_item: MdsItem3D = node.get_meta(MdsItem3D.META)
		new_item.dropped.emit()
}

@rpc("any_peer", "call_remote")
func remote_spawn(data: Dictionary):
	data["multiplayer_authority"] = multiplayer.get_unique_id()
	var callable_key: String = ""
	var callable: Callable = func(_node): pass
	if data.has("callable_key"):
		callable_key = data["callable_key"]
		callable = callables.get(callable_key)
	var new_node = spawn(data)
	callable.call(new_node)
