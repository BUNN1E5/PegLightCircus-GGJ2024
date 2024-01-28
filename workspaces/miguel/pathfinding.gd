extends CharacterBody3D

const BASE_UNIT_SPEED = 5
const ACCELERATION = 10
const CIRCLE_SIZE = 10
const STAGE_ENTRANCE_DELAY = 1
const MINIMUM_PERFORMANCE_TIME = 5
const MAXIMUM_PERFORMANCE_TIME = 5
const PERFORMANCE_STARTUP_TIME = 1
const EXIT_STAGE_DELAY = 5
const WANDER_MOVEMENT_TIMER = 1
const TOTAL_WANDER_MOVEMENTS = 3
const MAX_WANDER_DISTANCE = 8
const WANDER_SPEED = 3
const HEXAGON_SPEED = 2
const HEXAGON_MOVEMENT_DIAMETER = 4
const PERFORMANCE_MODES = ["wander", "static", "hexagon"]

@export var primaryPerformancePointPath: NodePath = ""
@export var secondaryPerformancePointPath: NodePath = ""
@export var entrancePointPath: NodePath = ""

@onready var agent: NavigationAgent3D = $NavigationAgent3D
@onready var entrancePoint: Marker3D = get_node(entrancePointPath)
@onready var performancePointA: Marker3D = get_node(primaryPerformancePointPath)
@onready var performancePointB: Marker3D = get_node(secondaryPerformancePointPath)

var unit_speed = BASE_UNIT_SPEED
var identifier = 0
var state = "spawning"
var performance_type = "static"
var movements = 0

func _ready():
	call_deferred("actor_setup")
	
func actor_setup():
	await get_tree().physics_frame
	enterStage()

# https://www.youtube.com/watch?v=EOocBMBbL-E
func _physics_process(delta):
	moveToLocation(delta)
	
func moveToLocation(delta):
	var direction = Vector3()
	
	direction = agent.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * unit_speed, ACCELERATION * delta)
	
	move_and_slide()

# https://www.reddit.com/r/godot/comments/vjge0n/could_anyone_share_some_code_for_finding_a/
func random_inside_unit_circle() -> Vector3:
	var theta : float = randf() * 2 * PI
	return Vector3(cos(theta),0, sin(theta)) * sqrt(randf())


func enterStage():
	# TODO: pick a performance type based on the performer.
	performance_type = PERFORMANCE_MODES[randi() % PERFORMANCE_MODES.size()]
	
	# delay entrance
	var delay = randf() * STAGE_ENTRANCE_DELAY
	print("entering stage in ", delay, " seconds")
	await get_tree().create_timer(delay).timeout
	print("entering stage now")
	state = "entering"

	agent.set_target_position(getPerformancePosition())
	
func getPerformancePosition():
	var character_num = get_meta("CharacterNum")

	if character_num == 0: 
		return performancePointA.position
	elif character_num == 1:
		return performancePointB.position
	else:
		assert("invalid character number selected")

func exitStage():
	print("exiting stage")
	state = "exiting"
	await get_tree().create_timer(EXIT_STAGE_DELAY).timeout
	
	# TODO: show stretcher animation on failure status.
	agent.set_target_position(entrancePoint.position)
	unit_speed = BASE_UNIT_SPEED
	
func doPerformance():
	state = "performing"
	
	var startDelay = PERFORMANCE_STARTUP_TIME
	print("getting ready to perform in ", startDelay, " seconds")
	await get_tree().create_timer(startDelay).timeout

	if performance_type == "static": 
		# if static performance, don't loop, just stay still for x time.
		doStaticPerformance()
	elif performance_type == "wander":
		print("doing wander performance")
		state = "wandering"
		movements = TOTAL_WANDER_MOVEMENTS
		unit_speed = WANDER_SPEED
		doWandering()
		
	elif performance_type == "hexagon":
		print("doing hexagon performance")
		state = "hexagoning"
		movements = 5
		unit_speed = HEXAGON_SPEED
		doHexagoning()
		
	else:
		assert("invalid performance type specified", performance_type)

func doStaticPerformance():
	var randomDelay = MINIMUM_PERFORMANCE_TIME + (randf() * MAXIMUM_PERFORMANCE_TIME)
	print("doing static performance for ", randomDelay, " seconds")
	await get_tree().create_timer(randomDelay).timeout
	print("done with dynamic performance")
	
	exitStage()

func doWandering(): 
	if movements >= 0:
		var target = random_inside_unit_circle() * MAX_WANDER_DISTANCE
		agent.set_target_position(target)
		print("wandering to position ", target)
		movements = movements - 1
	else:
		print("done with wander performance")
		finishPerformance()

func doHexagoning():
	if movements >= 0:
		var vertices = hexagonVertices(getPerformancePosition(), HEXAGON_MOVEMENT_DIAMETER)
		var target = vertices[movements]
		
		agent.set_target_position(target)
		print("walking to hexagon position ", target)
		movements = movements - 1
	else:
		print("done with hexagon performance")
		finishPerformance()

func finishPerformance():
	state = "done-performing"
	agent.set_target_position(getPerformancePosition())	

func hexagonVertices(origin: Vector3, distance: int):
	# The angles for each vertex of a regular hexagon
	var angles = [0, 60, 120, 180, 240, 300]
	# Convert degrees to radians
	for i in range(angles.size()):
		angles[i] *= PI / 180.0

	# Calculate the coordinates of each vertex
	var vertices = []
	for i in range(angles.size()):
		var angle = angles[i]
		var vertex = Vector3(origin.x + distance * cos(angle), origin.y, origin.z + distance * sin(angle))
		vertices.append(vertex)

	return vertices

# https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html
func _on_navigation_agent_3d_navigation_finished():
	print("finished navigation during state: ", state)
	if state == "entering":
		doPerformance()
	elif state == "exiting":
		enterStage()
	elif state == "wandering":
		doWandering()
	elif state == "hexagoning":
		doHexagoning()
	elif state == "done-performing":
		exitStage()
