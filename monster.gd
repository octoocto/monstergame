class_name Monster extends Resource

class Move:
    var name: String
    var description: String
    var category: String
    var power: int
    var accuracy: int
    var pp: int
    var type: String
    var contact: bool

    func get_damage_against(user: Monster, enemy: Monster) -> int:
        var mult := 1.0
        if type == user.type:
            mult *= 1.5

        mult *= randf_range(217.0 / 255.0, 1.0)

        return ((((((2 * user.level) / 5) + 2) * power * user.stat_atk / enemy.stat_def) / 50) + 2) * mult

const JSON_MOVES := preload("res://moves.json")

var name := "bulbasaur"

var type := "grass"

var health: int

var level := 5

var stat_hp := 45
var stat_atk := 49
var stat_def := 49
var stat_satk := 65
var stat_sdef := 65
var stat_spd := 45

var moves = []

var moves_pp = []

@export var db: Resource

func _init() -> void:
    add_move(0)
    add_move(1)
    health = get_max_hp()

func add_move(index: int) -> void:
    var move := Move.new()
    var move_data: Dictionary = JSON_MOVES.data[index]
    for property: Dictionary in move.get_property_list():
        var property_name: String = property.name
        print("reading move %d prop %s" % [index, property_name])
        if not property_name in move_data:
            print("not found")
            continue
        move.set(property_name, move_data[property_name])
    moves.append(move)
    moves_pp.append(move.pp)

func get_max_hp() -> int:
    return int(((((stat_hp + 8) * 2) * level) / 100.0) + level + 10)

func get_hp_percent() -> float:
    return health / float(get_max_hp())

func hurt(amount: int) -> void:
    health = max(0, health - amount)