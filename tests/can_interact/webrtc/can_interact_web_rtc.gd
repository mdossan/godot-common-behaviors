class_name CanInteractWebRTC
extends MdsTestScene

@onready var peer_a_webrtc: MultiplayerBench = %PeerA
@onready var peer_b_webrtc: MultiplayerBench = %PeerB

func _ready() -> void:
	test_label = "Can interact - WebRTC"
	test_case()

func _enter_tree() -> void:
	var server_multiplayer = SceneMultiplayer.new()
	get_tree().set_multiplayer(server_multiplayer, ^"/root/CanInteractWebRTC/PeerA")
	var client_multiplayer = SceneMultiplayer.new()
	get_tree().set_multiplayer(client_multiplayer, ^"/root/CanInteractWebRTC/PeerB")

func test_case():
	await peer_a_webrtc.socket_ready
	await peer_b_webrtc.socket_ready
	peer_a_webrtc.create_lobby()
	await peer_a_webrtc.lobby_created
	peer_b_webrtc.handle_join_lobby("42")
	await peer_a_webrtc.new_peer_connected
	peer_a_webrtc.start_game()
	await peer_b_webrtc.level_spawned
	
	await start_of_physics_frame
	await end_of_physics_frame
	
	# PeerB interact with cube
	await start_of_physics_frame
	send_input("interact_b", true)
	await end_of_physics_frame
	
	await start_of_physics_frame
	var peer_b_cube: Node3D = %PeerB.get_node("Level/World/Interactables/InteractableCube")
	await peer_b_cube.get_node("MultiplayerSynchronizer").delta_synchronized
	await end_of_physics_frame
	await start_of_physics_frame
	assert(peer_b_cube.rotation.y > 0, "Cube should be rotated on peer b")
	await end_of_physics_frame
	
	%PeerA.unmount()
	%PeerB.unmount()
	success.emit(self)
	end_test()
