@tool

extends EditorScript


func get_animation(file: Object, name: String) -> Dictionary:
    var animation_dict = {"name": name, "setrepeat": 0, "frame": [], "dorepeat": 0}

    while not file.eof_reached():
        var content = file.get_line().strip_edges().split(" ")
        for index in content.size():
            match content[index]:
                "setrepeat":
                    animation_dict["setrepeat"] = int(content[index + 1])
                "frame":
                    animation_dict["frame"].append({content[index + 1]: int(content[index + 2])})
                "dorepeat":
                    animation_dict["dorepeat"] = int(content[index + 1])

    return animation_dict


func _run():
    #var dir = DirAccess.open("pokemon")
    #for directory in dir.get_directories():
        #var name = String(directory)
        #var file = FileAccess.open("pokemon/" + name + "/anim.asm", FileAccess.READ)
        #var ani = get_animation(file, name)

    var name = "abra"
    var file = FileAccess.open("pokemon/" + name + "/anim.asm", FileAccess.READ)
    var ani = get_animation(file, name)
    print(ani)

    # var animation = Animation.new()
    # var track_index = animation.add_track(Animation.TYPE_VALUE)






