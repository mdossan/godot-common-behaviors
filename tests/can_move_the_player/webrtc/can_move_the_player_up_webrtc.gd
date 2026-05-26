class_name CanMoveThePlayerUpWebRTC extends MdsTestScene

@onready var peer_a_webrtc: MultiplayerBench = %PeerA
@onready var peer_b_webrtc: MultiplayerBench = %PeerB

var peer_a_player_a: PlayerMulti
var peer_a_player_b: PlayerMulti
var peer_b_player_a: PlayerMulti
var peer_b_player_b: PlayerMulti

func _ready() -> void:
	test_label = "Can move the player up - WebRTC"
	test_case()

func _enter_tree() -> void:
	var server_multiplayer = SceneMultiplayer.new()
	get_tree().set_multiplayer(server_multiplayer, ^"/root/CanMoveThePlayerUpWebRTC/PeerA")
	var client_multiplayer = SceneMultiplayer.new()
	get_tree().set_multiplayer(client_multiplayer, ^"/root/CanMoveThePlayerUpWebRTC/PeerB")

func test_case():
	await peer_a_webrtc.socket_ready
	await peer_b_webrtc.socket_ready
	peer_a_webrtc.create_lobby()
	await peer_a_webrtc.lobby_created
	peer_b_webrtc.handle_join_lobby("42")
	await peer_a_webrtc.new_peer_connected
	peer_a_webrtc.start_game()
	await peer_b_webrtc.level_spawned
	
	peer_a_player_a = %PeerA.get_node("Level/World/Players/PlayerA")
	peer_a_player_b = %PeerA.get_node("Level/World/Players/PlayerB")
	peer_b_player_a = %PeerB.get_node("Level/World/Players/PlayerA")
	peer_b_player_b = %PeerB.get_node("Level/World/Players/PlayerB")
	
	# Move up with Player A
	await start_of_physics_frame
	send_input("up", true)
	await end_of_physics_frame
	
	# PeerA position is updated immediatly
	assert(peer_a_player_a.position.z < 5.0, "[PeerA] PlayerA.position.z should have decreased")
	assert(peer_a_player_b.position.z == 10.0, "[PeerA] PlayerB.position.z should be 10")
	
	# PeerB position is updated after sync
	await start_of_physics_frame
	await peer_b_player_a.synchronizer.synchronized
	assert(peer_b_player_a.position.z < 5.0, "[PeerB] PlayerA.position.z should habe decreased")
	assert(peer_b_player_b.position.z == 10.0, "[PeerB] PlayerB.position.z should be 10")
	await end_of_physics_frame
	
	# Move up with Player B
	await start_of_physics_frame
	send_input("up_b", true)
	await end_of_physics_frame
	
	# PeerB position is updated immediatly
	assert(peer_b_player_b.position.z < 10.0, "[PeerB] PlayerB.position.z should decreased")
	assert(peer_a_player_b.position.z == 10.0, "[PeerA] PlayerB.position.z should be 10")
	
	# PeerA position is updated after sync
	await start_of_physics_frame
	await peer_a_player_b.synchronizer.synchronized
	assert(peer_a_player_b.position.z < 10.0, "[PeerA] PlayerB.position.z should have decreased")
	await end_of_physics_frame
	
	%PeerA.unmount()
	%PeerB.unmount()
	success.emit(self)
	end_test()
