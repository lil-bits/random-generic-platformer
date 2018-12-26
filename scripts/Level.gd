extends Node

export(String) var id

onready var checkpoint = $Checkpoints/InitialCheckpoint
const Player = preload("res://scenes/Player.tscn")
const BOTTOM_WORLD_LIMIT = 100
var coins = 0

func _ready():
    Game.current_level_id = id

    for enemy in get_tree().get_nodes_in_group("enemies"):
        enemy.connect("enemy_touched", self, "_on_enemy_touched")

    for coin in get_tree().get_nodes_in_group("coins"):
        coin.connect("coin_taken", self, "_increment_coins")

    for spawner in get_tree().get_nodes_in_group("spawners"):
        spawner.connect("spawned", self, "_spawned_enemy")

    for checkpoint in get_tree().get_nodes_in_group("checkpoints"):
        checkpoint.connect("checkpoint_reached", self, "_on_checkpoint_reached")

    $LevelExit.connect("level_finished", self, "_on_level_finished")
    $LevelMenu.connect("menu_activated", self, "_on_menu_activated")
    $LevelMenu.connect("menu_deactivated", self, "_on_menu_deactivated")
    $LevelMenu.connect("level_exited", self, "_on_level_exited")

    $HUD.show_start_level_message(Game.get_current_level().name)

    _spawn_player()

func _physics_process(_delta):
    if ($Player.position.y > BOTTOM_WORLD_LIMIT):
        _on_enemy_touched()

func _on_enemy_touched():
    get_tree().call_deferred("change_scene", "res://scenes/StartMenu.tscn")

func _increment_coins():
    coins += 1
    $HUD.update_values({"coins": coins})

func _on_level_finished():
    Game.save_current_level_progress(coins)
    get_tree().call_deferred("change_scene", "res://scenes/world/World.tscn")

func _on_menu_activated():
    get_tree().paused = true

func _on_menu_deactivated():
    get_tree().paused = false

func _on_level_exited():
    get_tree().call_deferred("change_scene", "res://scenes/world/World.tscn")

func _spawned_enemy(enemy):
    enemy.connect("enemy_touched", self, "_on_enemy_touched")

func _spawn_player():
    var player = Player.instance()
    player.name = "Player"
    player.global_position = checkpoint.get_spawner_global_position()

    self.add_child(player, true)

func _on_checkpoint_reached(reached_checkpoint):
    checkpoint = reached_checkpoint

    reached_checkpoint.get_node("SaveArea").set_deferred("monitoring", false)
