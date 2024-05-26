extends AnimatedSprite2D

var direction = Vector2.ZERO
var facing_direction = Vector2.ZERO

var turn_frames: int = 0
@export var MAX_TURN_FRAMES: int = 8

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

func set_animation_by_angle(angle: float):
	
	
	if abs(angle) < PI / 2:

		self.flip_h = false

		if angle < -PI/3:
			self.animation = "back"
		elif angle < -PI/6:
			self.animation = "up_diagonal"
		elif angle < PI/6:
			self.animation = "running"
		elif angle < PI/3:
			self.animation = "diagonal"
		else:
			self.animation = "front"
	else:

		if angle > 0:
			angle = PI - angle
		else:
			angle = -PI - angle
			
		self.flip_h = true

		if angle < -PI/3:
			self.animation = "back"
		elif angle < -PI/6:
			self.animation = "up_diagonal"
		elif angle < PI/6:
			self.animation = "running"
		elif angle < PI/3:
			self.animation = "diagonal"
		else:
			self.animation = "front"

	#
	#if -PI/6  < angle and angle < PI/6:
		#self.animation = "running"
		#self.flip_h = false
	#elif PI/6 < angle and angle < 2*PI/6:
		#self.animation = "diagonal"
		#self.flip_h = false
	#elif 2*PI/6 < angle and angle < 2*PI/3:
		#self.animation = "front"
		#self.flip_h = false
	#elif 2*PI/3 < angle and angle < 5*PI/6:
		#self.animation = "diagonal"
		#self.flip_h = true
	#elif 5*PI/6 < angle and angle < 7*PI/6:
		#self.animation = "running"
		#self.flip_h = true
	#elif 7*PI/6 < angle and angle < 8*PI/6:
		#self.animation = "up_diagonal"
		#self.flip_h = true

func _physics_process(delta):
	
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	if Input.is_action_just_pressed("Run"):
		SPEED = 5.0
		self.speed_scale = 2
	elif Input.is_action_just_released("Run"):
		SPEED = 2.0
		self.speed_scale = 1
	
	translate(direction * SPEED)
	
	if direction != Vector2.ZERO:
		facing_direction = facing_direction.slerp(direction, 0.1)

	#print(facing_direction, "\tangle:", facing_direction.angle(), "\t", "lenght:", facing_direction.length())
	
	set_animation_by_angle(facing_direction.angle())
	# if direction.x > 0:
		
	# 	if direction.y == 0:
			
	# 		self.animation = "running"
	# 		self.flip_h = false

	# 	elif direction.y > 0:
	# 		self.animation = "diagonal"
	# 		self.flip_h = false
	# 	else:
	# 		self.animation = "up_diagonal"
	# 		self.flip_h = false
	# elif direction.x < 0:
		
	# 	if direction.y == 0:
			
	# 		self.animation = "running"
	# 		self.flip_h = true

	# 	elif direction.y > 0:
	# 		self.animation = "diagonal"
	# 		self.flip_h = true
	# 	else:
	# 		self.animation = "up_diagonal"
	# 		self.flip_h = true
	# elif direction == Vector2.UP:

	# elif direction == Vector2.DOWN:
	# 	if last_vertical_direction == Vector2.UP:
	# 		self.animation = "running"

	# 		check_turn_frames_vertical(Vector2.DOWN)
	# 	else:
	# 		self.animation = "front"
	# 		last_vertical_direction = Vector2.DOWN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
