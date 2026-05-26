class_name CanMoveThePlayerRightWebRTC extends MdsTestScene

@onready var peer_a_webrtc: MultiplayerBench = %PeerA
@onready var peer_b_webrtc: MultiplayerBench = %PeerB

var peer_a_player_a: PlayerMulti
var peer_a_player_b: PlayerMulti
var peer_b_player_a: PlayerMulti
var peer_b_player_b: PlayerMulti

func _ready() -> void:
	test_label = "Can move the player right - WebRTC"
	test_case()

func _enter_tree() -> void:
	var server_multiplayer = SceneMultiplayer.new()
	get_tree().set_multiplayer(server_multiplayer, ^"/root/CanMoveThePlayerRightWebRTC/PeerA")
	var client_multiplayer = SceneMultiplayer.new()
	get_tree().set_multiplayer(client_multiplayer, ^"/root/CanMoveThePlayerRightWebRTC/PeerB")

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
	
	# Move up with PeerA
	await start_of_physics_frame
	send_input("right", true)
	await end_of_physics_frame
	
	# Assert PeerA local changes
	assert(peer_a_player_a.position.x > 5, "[PeerA] PlayerA.position.x should have increased")
	assert(peer_a_player_b.position.x == 10, "[PeerA] Player B should not have moved")
	
	# Assert PeerB after sync
	await start_of_physics_frame
	await peer_b_player_a.synchronizer.synchronized
	assert(peer_b_player_a.position.x > 5, "[PeerB] PlayerA.position.x should be positive")
	assert(peer_b_player_b.position.x == 10, "[PeerB] PlayerB.position.x should not have moved")
	await end_of_physics_frame
	
	# Move up with PeerB
	await start_of_physics_frame
	send_input("right_b", true)
	await end_of_physics_frame
	
	# Assert PeerB local changes
	assert(peer_b_player_b.position.x > 10, "[PeerB] PlayerB.position.x should have increased")
	
	# Assert PeerA side after sync
	await start_of_physics_frame
	await peer_a_player_b.synchronizer.synchronized
	assert(peer_a_player_b.position.x > 10, "[PeerA] PlayerB.position.x should have increased")
	await end_of_physics_frame
	
	%PeerA.unmount()
	%PeerB.unmount()
	success.emit(self)
	end_test()
