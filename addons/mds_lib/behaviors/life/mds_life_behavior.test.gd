extends GutTest

var scene = preload("res://addons/mds_lib/behaviors/life/mds_life_behavior.tscn")

func test_life_behavior():
	# Arrange: Create root node
	var root_node = Node.new()
	
	# Arrange: Create Behavior node
	var behavior: MdsLifeBehavior = scene.instantiate()
	behavior.parent = root_node
	behavior.start_life = 50.0
	watch_signals(behavior)
	root_node.add_child(behavior)
	
	# Arrange: Spawn root_node to the scene
	add_child_autofree(root_node)
	
	# Assert: Start with start_life amout
	assert_eq(behavior.life, 50.0, "Default value should be 50")
	
	# Arrange: Reset life to 100
	behavior.life = 100
	
	# Act: Take Damage
	behavior.take_damage(20.0)
	
	# Assert: Damage taken
	assert_signal_emitted_with_parameters(behavior.damage_taken, [20.0, 80.0])
	assert_eq(behavior.life, 80.0, "life should be 80")
	
	# Act: Heal
	behavior.heal(10.0)
	
	# Assert: Damange taken
	assert_signal_emitted_with_parameters(behavior.heal_taken, [10.0, 90.0])
	assert_eq(behavior.life, 90.0, "life should be 90")
	
	# Act: Die
	clear_signal_watcher() # Need to clear because damage_taken already emitted
	watch_signals(behavior)
	behavior.take_damage(1000.0)
	
	# Assert: Damange taken
	assert_signal_not_emitted(behavior.damage_taken)
	assert_signal_emitted_with_parameters(behavior.dead, [])
	assert_eq(behavior.life, 0.0, "life should be 0")
	
