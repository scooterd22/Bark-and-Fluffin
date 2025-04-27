extends CharacterBody2D

var dog: CharacterBody2D
@export var move_speed := 165.0
@onready var target = $"../Dog" 

@export var wander_speed := 20.0 #speed feels really good!
@export var flee_speed := 100.0
@export var flee_distance := 50.0  # start fleeing if dog is closer than this
@export var wander_change_interval := randi_range(1, 5) #currently this feels okay lol, not great but okay
var wander_direction: Vector2 = Vector2.ZERO
var wander_timer: float = 0.0
var scared = false
var scared_timer = 0.0
@export var scared_duration := 0.5


# Called when the node enters the scene tree for the first time.
func _ready():
	dog = get_node("../Dog")
	dog.dogBarked.connect(_on_dog_barked)
	

func _on_dog_barked():
	#print("oh shit!!")
	flee()
	
func flee():
	scared = true
	scared_timer = scared_duration
	$Bah.play()
	
	# maybe you can also trigger a "runaway" flag here

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = dog.global_position.distance_to(self.global_position) 
	var to_dog = dog.global_position - global_position
	var distance_to_dog = to_dog.length()
	
	if distance <= flee_distance:
		#print("oh shit!! fleeing")
		flee()

	
	
	if not target:
		return
		
	if scared:
		scared_timer -= delta
		if scared_timer <= 0:
			scared = false
	if scared:
		# run away from the dog
		var direction_away = (global_position - dog.global_position).normalized()
		velocity = direction_away * flee_speed
	else:
		wander_timer -= delta #once a second the wander time goes down 
		if wander_timer <= 0: # when the timer hits 0
			#print("wandering")
			wander_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() #picks random direction
			wander_timer = wander_change_interval #sets timer to new change intervval
			velocity = wander_direction * wander_speed #calculates speed with 
			# this handles collisions automatically 
		
	move_and_slide()
	
	
	# do random movement for sheep
	
