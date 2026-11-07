class_name Player
extends Node

@onready var health: HealthComponent = %Health

@onready var is_ready: IsReadyComponent = %IsReady

@onready var score: ScoreComponent = %Score

var id: int


func _init(_id: int):
	id = _id
