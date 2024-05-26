extends AnimatedSprite2D

var direction = Vector2.ZERO
var last_direction = Vector2.ZERO

var turn_frames: int = 0
var MAX_TURN_FRAMES: int = 8
var acceleration = Vector2.ZERO

var SPEED: float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
				#
	if event.is_pressed():
		self.play()
	else:
		self.stop()

func check_turn_frames(target: Vector2):
	if turn_frames >= MAX_TURN_FRAMES:
		turn_frames = 0
		last_direction = target
	else:
		turn_frames += 1

func _physics_process(delta):
	
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	if Input.is_action_just_pressed("Run"):
		SPEED = 5.0
		self.speed_scale = 2
	elif Input.is_action_just_released("Run"):
		SPEED = 2.0
		self.speed_scale = 1
	
	translate(direction * SPEED)
	if direction == Vector2.RIGHT:
		
		if last_direction == Vector2.LEFT:
			self.animation = "front"
			
			check_turn_frames(Vector2.RIGHT)

		else:
			self.animation = "running"
			self.flip_h = false
			last_direction = Vector2.RIGHT
	elif direction == Vector2.LEFT:
		
		if last_direction == Vector2.RIGHT:
			self.animation = "front"
			
			check_turn_frames(Vector2.LEFT)
		else:
			self.animation = "running"
			self.flip_h = true
	
			last_direction = Vector2.LEFT
	elif direction == Vector2.UP:
		self.animation = "front"
		self.flip_h = false
	elif direction == Vector2.DOWN:
		self.animation = "front"
		self.flip_h = false
		
	
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
