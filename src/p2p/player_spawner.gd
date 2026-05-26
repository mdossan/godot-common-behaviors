extends MultiplayerSpawner

var player_scene: PackedScene = preload("res://src/p2p/player_multi.tscn")

func _enter_tree() -> void:
	spawn_function = custom_spawn

func custom_spawn(peer_id: int):
	var p: PlayerMulti = player_scene.instantiate()
	p.set_multiplayer_authority(peer_id)
	p.player_id = peer_id
	return p
