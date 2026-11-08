class_name Battlefield
extends Node3D

@onready var backplane_wall_1: BackplaneWall = $BackplaneWall1

@onready var backplane_wall_2: BackplaneWall = $BackplaneWall2

@onready var paddle_1: Paddle = $Paddle1

@onready var paddle_2: Paddle = $Paddle2

# REMOVE WHEN DONE
var test_health_1 := HealthComponent.new()
var test_health_2 := HealthComponent.new()

var test_score_1 := ScoreComponent.new()
var test_score_2 := ScoreComponent.new()


func _ready() -> void:
	backplane_wall_1.ball_hit.connect(_on_backwall_hit)
	backplane_wall_2.ball_hit.connect(_on_backwall_hit)

	# REMOVE WHEN DONE
	test_health_1.health = 3
	test_health_2.health = 3

	test_score_1.score = 0
	test_score_2.score = 0


func _on_backwall_hit(wall: BackplaneWall) -> void:
	var scoring_player: Player
	var losing_player: Player

	if wall == backplane_wall_1:
		scoring_player = backplane_wall_2.player
		losing_player = backplane_wall_1.player
	else:
		scoring_player = backplane_wall_1.player
		losing_player = backplane_wall_2.player

	losing_player.health.health -= 1
	scoring_player.score.score += 1
