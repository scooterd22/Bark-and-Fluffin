extends CharacterBody2D

@export var speed := 150.0
@export var sprintSpeed := 300.0
@export var sprinting = false
signal dogBarked
var sprintDuration = 1.0 
var sprintTimer = 0.0
var barkingCooldown = true
var barkingCooldownTime = 2.0
var barkingCooldownTimer = 0.0


func _physics_process(delta):
	# checks to see if they are sprinting then changes the speed to make them sprint
	if Input.is_action_pressed("shift") and sprinting == false:
		sprinting = true
		sprintTimer = sprintDuration
		
	if sprinting:
		sprintTimer -= delta
		if sprintTimer <= 0.0:
			sprinting = false
		
	if sprinting:
		speed = sprintSpeed
	else:
		speed = 150.0
	
	if barkingCooldown:
		barkingCooldownTimer -= delta
		if barkingCooldownTimer <= 0.0:
			print("does this run")
			barkingCooldown = false
			get_parent().get_node("Label").text = "can bark"
		
	if Input.is_action_just_pressed("Bark") and barkingCooldown == false:
		barkingCooldown = true
		get_parent().get_node("Label").text = "can't bark"
		barkingCooldownTimer = barkingCooldownTime
		$BarkPlayer.play()
		emit_signal("dogBarked")
		await $BarkPlayer.finished

	var input = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	velocity = input * speed
	move_and_slide()
	
	
	
	
	

