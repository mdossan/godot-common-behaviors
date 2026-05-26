class_name PlayerMulti extends CharacterBody3D

@export var player_id: int
@export var mds_test: MdsTestScene
@export var event_suffix: String

@onready var synchronizer: MultiplayerSynchronizer = $MultiplayerSynchronizer

func _enter_tree() -> void:
	set_multiplayer_authority(player_id)

func _ready():
	if event_suffix:
		%MdsMovement.up_action = "up_" + event_suffix
		%MdsMovement.down_action = "down_" + event_suffix
		%MdsMovement.left_action = "left_" + event_suffix
		%MdsMovement.right_action = "right_" + event_suffix
		%MdsPickAction3D.pick_action = "pick_" + event_suffix
		%MdsInteractAction3D.interact_action = "interact_" + event_suffix

func _physics_process(_delta: float) -> void:
	if mds_test:
		mds_test.end_of_server_frame.emit()
