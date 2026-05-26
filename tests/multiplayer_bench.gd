class_name MultiplayerBench
extends MdsWebRTC

signal players_spawned
signal level_spawned

@export var x_scale: int = 1
@export var expected_players: int = 2
@export var level_path: String

var player_a: PlayerMulti
var player_b: PlayerMulti

func _enter_tree() -> void:
	%Level.scale.x = x_scale

func _on_game_started(_peer_ids: Array[int]) -> void:
	if level_path:
		%LevelSpawner.spawn(level_path)
		return

func unmount():
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
	queue_free()

func _on_level_spawn(_node: Node) -> void:
	level_spawned.emit()
