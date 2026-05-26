extends MultiplayerSpawner

@export var host_id: int = 42

func _enter_tree() -> void:
	spawn_function = custom_spawn

func custom_spawn(level_path: String):
	var level_res: PackedScene = load(level_path)
	var level = level_res.instantiate()
	level.set_multiplayer_authority(host_id)
	return level
