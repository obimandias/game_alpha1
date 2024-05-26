extends AnimatedSprite2D

var direction = Vector2.ZERO
var last_horizontal_direction = Vector2.ZERO
var last_vertical_direction = Vector2.ZERO

var turn_frames: int = 0
@export var MAX_TURN_FRAMES: int = 8
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

func check_turn_frames_horizontal(target: Vector2):
	if turn_frames >= MAX_TURN_FRAMES:
		turn_frames = 0
		last_horizontal_direction = target
	else:
		turn_frames += 1

func check_turn_frames_vertical(target: Vector2):
	if turn_frames >= MAX_TURN_FRAMES:
		turn_frames = 0
		last_vertical_direction = target
	else:
		turn_frames += 1

func _physics_process(delta):
	
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	#print(direction)
	
	if Input.is_action_just_pressed("Run"):
		SPEED = 5.0
		self.speed_scale = 2
	elif Input.is_action_just_released("Run"):
		SPEED = 2.0
		self.speed_scale = 1
	
	translate(direction * SPEED)
	
	if direction.x > 0:
		
		if direction.y == 0:
			
			self.animation = "running"
			self.flip_h = false
			
			#if last_horizontal_direction == Vector2.LEFT:
				#self.animation = "front"
				#
				##check_turn_frames_horizontal(Vector2.RIGHT)
#
			#else:
				#self.animation = "running"
				#self.flip_h = false
				#last_horizontal_direction = Vector2.RIGHT
		elif direction.y > 0:
			self.animation = "diagonal"
			self.flip_h = false
		else:
			self.animation = "up_diagonal"
			self.flip_h = false
	elif direction.x < 0:
		
		if direction.y == 0:
			
			self.animation = "running"
			self.flip_h = true
			#
			#if last_horizontal_direction == Vector2.RIGHT:
				#self.animation = "front"
				#
				#check_turn_frames_horizontal(Vector2.LEFT)
			#else:
				#self.animation = "running"
				#self.flip_h = true
		
				#last_horizontal_direction = Vector2.LEFT
		elif direction.y > 0:
			self.animation = "diagonal"
			self.flip_h = true
		else:
			self.animation = "up_diagonal"
			self.flip_h = true
	elif direction == Vector2.UP:

		if last_vertical_direction == Vector2.DOWN:
			self.animation = "running"

			check_turn_frames_vertical(Vector2.UP)
		else:
			self.animation = "back"
			last_vertical_direction = Vector2.UP

	elif direction == Vector2.DOWN:
		if last_vertical_direction == Vector2.UP:
			self.animation = "running"

			check_turn_frames_vertical(Vector2.DOWN)
		else:
			self.animation = "front"
			last_vertical_direction = Vector2.DOWN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
