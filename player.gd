class_name Player

var monsters: Array[Monster] = []

var current_monster := 0

func _init() -> void:
    monsters.append(Monster.new())

func get_current_monster() -> Monster:
    return monsters[current_monster]

func get_total_moves() -> int:
    return len(monsters[current_monster].moves)

func get_move(index: int) -> Monster.Move:
    if len(monsters[current_monster].moves) > index:
        return monsters[current_monster].moves[index]
    return null

func get_move_pp(index: int) -> int:
    if len(monsters[current_monster].moves_pp) > index:
        return monsters[current_monster].moves_pp[index]
    return 0
