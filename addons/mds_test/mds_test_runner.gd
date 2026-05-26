class_name MdsTestRunner extends Node

@export var tests: Array[PackedScene]

var count: int = 0;
var success_counter: int = 0;
var fail_counter: int = 0;
var test_in_progress: bool = false
var current_test: MdsTestScene

func _physics_process(delta: float) -> void:
	if test_in_progress:
		return
	
	if tests.is_empty():
		return
	
	test_in_progress = true
	var test_scene: PackedScene = tests.pop_front()
	var test_node: MdsTestScene = test_scene.instantiate()
	test_node.disabled = false # Test Node is disabled by default to allow manual testing of the scene
	test_node.success.connect(_on_success)
	test_node.fail.connect(_on_fail)
	test_node.tree_exited.connect(_on_test_exited)
	current_test = test_node
	get_tree().root.add_child(current_test)

func _on_success(test_scene: MdsTestScene):
	print_debug("[MdsTestRunner][OK] %s" % test_scene.test_label)
	test_scene.process_mode = Node.PROCESS_MODE_DISABLED
	success_counter += 1
	test_scene.queue_free()

# TODO: pass a reason to log properly
func _on_fail(test_scene: MdsTestScene):
	print_debug("[MdsTestRunner][FAIL] %s" % test_scene.test_label)
	push_error("[MdsTestRunner][FAIL] %s" % test_scene.test_label)
	test_scene.process_mode = Node.PROCESS_MODE_DISABLED
	fail_counter += 1
	test_scene.queue_free()

func _on_test_exited():
	test_in_progress = false
