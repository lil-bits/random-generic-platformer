extends Path2D

export(PackedScene) var coin_scene

func _ready():
    var pos_curve = self.get_curve()
    var total_coins = pos_curve.get_point_count()

    for i in range(0, total_coins):
        var coin = coin_scene.instance()
        add_child(coin)
        coin.position = pos_curve.get_point_position(i)
