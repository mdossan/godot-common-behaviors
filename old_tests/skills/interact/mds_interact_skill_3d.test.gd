extends GutTest

var single_custom_interaction_bench = preload("res://tests/skills/interact/test_bench_single_custom_interaction.tscn")

# See: https://github.com/bitwes/Gut/issues/642
var _sender: GutInputSender = GutInputSender.new(Input)

func before_all():
	_sender.wait_frames(10)

func after_all():
	_sender.release_all()
	_sender.clear()
	# Wait for key release to be processed. Otherwise the key release is
	# leaked to the next test and it detects an extra key release.
	await wait_physics_frames(1)

func test_single_custom_interaction():
	# Arrange
	var test_scene: TestBenchSingleCustomInteraction = single_custom_interaction_bench.instantiate()
	add_child_autofree(test_scene)
	watch_signals(test_scene.custom_interaction)

	# Act
	_sender.action_down("interact").wait_frames(1)

	# Assert
	var has_emitted = await wait_for_signal(test_scene.custom_interaction.interacting, 1)
	assert_eq(has_emitted, true, "`interacting` signal should be emitted")
	assert_eq(test_scene.interaction_registered, true)
