extends Node2D

var spawn_walls = true
var total_walls : int = 0
var last_wall_pos = 0
var points = 0
var game_running = true
const MAXIMUM_WALLS = 7
const WALLS_PRELOAD = preload("res://scenes/walls.tscn")
const SPACE_BETWEEN_WALLS = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, MAXIMUM_WALLS):
		total_walls += 1
		spawn_wall(last_wall_pos + SPACE_BETWEEN_WALLS)
	get_node('HUD').get_node('Start').hide()
	get_node('Player').block_player_input = true
		
func reset():
	total_walls = 0
	last_wall_pos = 0

func spawn_wall(posx):
	var wall_instance = WALLS_PRELOAD.instantiate()
	wall_instance.position.y = randi_range(-200, 200)
	wall_instance.position.x = posx + SPACE_BETWEEN_WALLS
	last_wall_pos = wall_instance.position.x

	
	self.get_node('AllWalls').call_deferred('add_child', wall_instance)
	#self.add_child(wall_instance)
	print('new wall added')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not game_running:
		if Input.is_action_pressed('ui_accept'):
			get_node('HUD').get_node('Start').hide()
			game_running = true
			for wall in get_node("AllWalls").get_children():
				wall.wall_speed = -400
			get_node('Player').hard_coded_speed = false



func _on_resetter_area_entered(area):
	print('wall deleted')
	area.get_parent().queue_free()
	spawn_walls = false
	spawn_wall(1150)

func _on_point_detector_area_entered(area):
	if area.name == 'CenterDetector':
		points += 1
		get_node('HUD').get_node('Score').text = str(points)
	elif area.name == 'CenterPauseGame':
		area.queue_free()
		get_node('HUD').get_node('Start').show()
		get_node('Player').hard_coded_speed = true
		get_node('Player').velocity.y = get_node('Player').MAX_UP_VELOCITY
		get_node('Player').block_player_input = false

		game_running = false
		
		for wall in get_node("AllWalls").get_children():
			wall.wall_speed = 0
	else:
		get_tree().reload_current_scene()
