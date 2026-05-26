class_name TestMdsPickAction3DP2PCanPickItem extends MdsTestScene

@export var server_players: Node3D

@onready var peer_a_webrtc: MdsWebRTC = $PeerA
@onready var peer_b_webrtc: MdsWebRTC = $PeerB

var peer_a_player_a: PlayerMulti
var peer_a_player_b: PlayerMulti
var peer_b_player_a: PlayerMulti
var peer_b_player_b: PlayerMulti

func _ready() -> void:
	test_label = "MdsPickAction3D - WebRTC - Can pick an item"
	test_case()

func _enter_tree() -> void:
	var peer_a_multiplayer = SceneMultiplayer.new()
	get_tree().set_multiplayer(peer_a_multiplayer, ^"/root/TestMdsPickAction3DP2PCanPickItem/PeerA")
	var peer_b_multiplayer = SceneMultiplayer.new()
	get_tree().set_multiplayer(peer_b_multiplayer, ^"/root/TestMdsPickAction3DP2PCanPickItem/PeerB")

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
	
	# Collision with target area should occur,
	# so we wait for one physics frame
	await start_of_physics_frame
	
	# Frame 1 - Send input event
	await start_of_physics_frame
	var action = InputEventAction.new()
	action.action = "pick_b"
	action.pressed = true
	Input.parse_input_event(action)
	Input.flush_buffered_events()
	await end_of_physics_frame
	
	# Assert
	assert(peer_b_player_b.get_node("MdsInventoryBehavior3D").get_child_count() == 1, "[PeerB][PlayerB] Should have item")
	assert(peer_a_player_b.get_node("MdsInventoryBehavior3D").get_child_count() == 0, "[PeerA][PlayerB] Should not have item")

	# Synchronization with players take one frame
	# So wait one frame to see the item of Player B in Player A "screen
	await start_of_physics_frame
	await start_of_physics_frame
	assert(peer_a_player_b.get_node("MdsInventoryBehavior3D").get_child_count() == 1, "[PeerA][PlayerB] Should have item")
	assert(peer_a_player_b.get_node("MdsInventoryBehavior3D").get_child_count() == 1, "[PeerA][PlayerB] Should have item")
	assert(%PeerA.get_node("Level/World/Items").get_child_count() == 0, "[PeerA][World] Items should be empty")
	await end_of_physics_frame
	
	# RPC to peer A as been sent so wait one frame to remove the item from global
	await start_of_physics_frame
	assert(%PeerA.get_node("Level/World/Items").get_child_count() == 0, "[PeerA][World] Items should be empty")
	await end_of_physics_frame
	
	%PeerA.unmount()
	%PeerB.unmount()
	success.emit(self)
	end_test()
