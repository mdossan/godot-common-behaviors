extends Node3D

@export var mds_test: MdsTestScene
@export var player_a: PlayerMulti
@export var player_b: PlayerMulti

func _player_spawned(spawned_player: PlayerMulti) -> void:
	if spawned_player.player_id == 42:
		player_a = spawned_player
	if spawned_player.player_id == 43:
		player_b = spawned_player
