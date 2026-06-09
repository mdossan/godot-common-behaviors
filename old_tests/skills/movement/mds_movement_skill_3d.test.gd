extends GutTest

var test_bench = preload("res://tests/skills/movement/test_bench_movement.tscn")

var _sender: GutInputSender = GutInputSender.new(Input)

func before_all():
	_sender.wait_frames(10)

func after_all():
	_sender.release_all()
	_sender.clear()
	await wait_physics_frames(1)

func test_movement_up():
	var test_scene: TestBenchMovement = test_bench.instantiate()
	add_child_autofree(test_scene)
	assert_eq(test_scene.player.position.z, 0.0)
	
	_sender.action_down("up").wait_frames(1)
	
	assert_lt(test_scene.player.position.z, 0.0)
