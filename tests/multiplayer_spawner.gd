extends MultiplayerSpawner
var player_scene: PackedScene = preload("res://tests/props/p2p/player_multi.tscn")

@export var mds_test: MdsTestScene

func _enter_tree() -> void:
	spawn_function = _on_spawn

func _on_spawn(_peer_id: int):
	var p: PlayerMulti = player_scene.instantiate()
	p.mds_test = mds_test
	return p
