class_name P2pPlayerSpawner extends Node3D

signal player_spawned(player: PlayerMulti)

@onready var multiplayer_spawner: MultiplayerSpawner = %PlayerSpawner

func start_game(peer_ids: Array[int]):
	for peer_id in peer_ids:
		var n = %PlayerSpawner.spawn(peer_id)
		player_spawned.emit(n)

func _on_player_spawned(node: Node) -> void:
	player_spawned.emit(node)
