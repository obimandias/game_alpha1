extends CharacterBody2D

var direction = Vector2.ZERO
var facing_direction = Vector2.ZERO

var visible_rect: Rect2 = Rect2(0,0,0,0)

var turn_frames: int = 0
@export var MAX_TURN_FRAMES: int = 8
@export var ANIMATION_WALK_SPEED: float = 2.0
@export var ANIMATION_RUN_SPEED: float = 5.0

@onready var sprite = $sprite

var SPEED: float = 1.0

signal points_up

func _ready():
    sprite.speed_scale = ANIMATION_WALK_SPEED
    var viewport = self.get_viewport();
    visible_rect = viewport.get_visible_rect()



func set_animation_by_angle(angle: float):

    if abs(angle) < PI / 2:
        sprite.flip_h = false
    else:
        if angle > 0:
            angle = PI - angle
        else:
            angle = -PI - angle
        sprite.flip_h = true

    if angle < - PI / 3:
        sprite.animation = "back"
    elif angle < - PI / 6:
        sprite.animation = "up_diagonal"
    elif angle < PI / 6:
        sprite.animation = "running"
    elif angle < PI / 3:
        sprite.animation = "diagonal"
    else:
        sprite.animation = "front"

func _physics_process(delta):

    direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

    if direction == Vector2.ZERO:
        sprite.stop()
    else:
        sprite.play()

    if Input.is_action_just_pressed("Run"):
        SPEED = 5.0
        sprite.speed_scale = ANIMATION_RUN_SPEED
    elif Input.is_action_just_released("Run"):
        SPEED = 1.0
        sprite.speed_scale = ANIMATION_WALK_SPEED

    if direction == Vector2.UP or direction == Vector2.DOWN:
        move_and_collide(direction * SPEED)

    else:
        move_and_collide(direction * SPEED * 3)


    if direction != Vector2.ZERO:
        facing_direction = facing_direction.slerp(direction, 0.15)

    set_animation_by_angle(facing_direction.angle())

    var new_scale = remap(self.position.y,0, visible_rect.size.y, 0.5, 1.1)
    self.scale = Vector2(new_scale, new_scale)


func _process(delta):
    pass
