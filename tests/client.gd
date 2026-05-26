extends Node3D

@export var mds_test: MdsTestScene

func _ready() -> void:
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client("127.0.0.1", 7777)
	multiplayer.multiplayer_peer = client_peer

func _on_spawn(_node):
	mds_test.client_ready.emit()
