extends Node3D

@export var mds_test: MdsTestScene

func _ready() -> void:
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(7777, 10)
	server_peer.peer_connected.connect(_on_peer_connected)
	multiplayer.multiplayer_peer = server_peer

func _on_peer_connected(peer_id: int):
	%MultiplayerSpawner.spawn(peer_id)

func _on_multiplayer_spawner_spawned(node: Node) -> void:
	node.ready.connect(func():
		mds_test.server_ready.emit()
	)
