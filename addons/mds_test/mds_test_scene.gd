class_name MdsTestScene extends Node

signal success(t: MdsTestScene)
signal fail(t: MdsTestScene)

signal server_ready
signal end_of_server_frame
signal client_ready
signal peer_b_ready

signal start_of_physics_frame
signal end_of_physics_frame

signal input_received

var fail_fast: bool = true
var test_label: String = "Default Test"
var current_frame: int = 0
# Test Node is disabled by default to allow manual testing of the scene
var disabled: bool = true
var debug: bool = false

func _on_timeout_timer_timeout() -> void:
	fail.emit(self)

func _physics_process(_delta: float) -> void:
	#print("[TestScene] _physics_process")
	if disabled:
		return
	if debug:
		print_debug("[MdsTestScene][%s] Process" % [current_frame])
	start_of_physics_frame.emit()
	current_frame += 1
	call_deferred("end_frame")

func end_frame():
	end_of_physics_frame.emit()

func end_test():
	disabled = true
	queue_free()

func mds_assert(cond, message):
	if fail_fast:
		assert(cond, message)
	else:
		fail.emit(message)

func send_input(action_name: String, pressed: bool):
	var action = InputEventAction.new()
	action.action = action_name
	action.pressed = pressed
	Input.parse_input_event(action)
	Input.flush_buffered_events()
