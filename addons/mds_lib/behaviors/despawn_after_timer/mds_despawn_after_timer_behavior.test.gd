extends GutTest

var scene = preload("res://addons/mds_lib/behaviors/despawn_after_timer/mds_despawn_after_timer_behavior.tscn")

func test_should_despawn():
	# Arrange: Create root node
	var root_node = Node.new()
	
	# Arrange: Create Behavior node
	var behavior: MdsDespawnAfterTimerBehavior = scene.instantiate()
	behavior.target = root_node
	behavior.despawn_delay = 0.1 # Reduce delay to improve test run time
	root_node.add_child(behavior)
	
	# Arrange: Spawn root_node to the scene
	add_child_autofree(root_node)
	
	# Act
	behavior.despawn()
	
	# Assert
	var signal_received = await wait_for_signal(behavior.despawned, 1)
	assert_eq(signal_received, true, "despawned signal should be emitted")
	assert_freed(root_node)
