extends Node2D

const MAXIMUM_WALLS = 14
const WALLS_PRELOAD = preload("res://scenes/walls.tscn")
var total_walls = 0
var last_wall_position : int

# Called when the node enters the scene tree for the first time.
func _ready():
	while total_walls < MAXIMUM_WALLS:
		spawn_wall()

func spawn_wall():
	const SPACE_BETWEEN_WALLS = 400
	var wall_instance = WALLS_PRELOAD.instantiate()
	
	wall_instance.position.y = randi_range(-100, 100)
	wall_instance.position.x = last_wall_position + SPACE_BETWEEN_WALLS
	last_wall_position = wall_instance.position.x
	self.add_child(wall_instance)
	total_walls += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_resetter_area_entered(area):
	print(total_walls)
	area.get_parent().queue_free()
	total_walls -= 1
	print(total_walls)
	spawn_wall()
