local function string_contains(str, val)
    for i = 1, #str
    do
        if string.sub(str, i, i) == val
        then
            return true
        end
    end

    return false
end

local function array_contains(arr, val)
    for i = 1, #arr
    do
        if arr[i] == val
        then
            return true
        end
    end

    return false
end

local function replace_char(str, chr, pos)
    return string.format("%s%s%s", string.sub(str, 1, pos-1), chr, string.sub(str, pos +1))
end

local function get_player_character()
    input_result = io.read()
    if string.len(input_result) ~= 1
    then
        print("Invalid length")
        return " "
    end

    return string.lower(input_result)
end

local function display_game(hp, word, already_used_char, used_letters)
    os.execute("cls")

    print("John Lua is a bad man and is on the hook! Can you save him.")

    if already_used_char ~= " "
    then
        print(string.format("Already guessed: %s", already_used_char))
    end

    if #used_letters > 0
    then
        used_letters_join = used_letters
        print("Used letters:", table.concat(used_letters, ", "))
    end

    if hp <= 5 then head = "O" else head = " " end
    if hp <= 4 then larm = "/" else larm = " " end
    if hp <= 3 then torso = "|" else torso = " " end
    if hp <= 2 then rarm = "\\" else rarm = " " end
    if hp <= 1 then lleg = "/" else lleg = " " end
    if hp <= 0 then rleg = "\\" else rleg = " " end

    gallow = "  +---+\r\n  |   |\r\n  %s   |\r\n %s%s%s  |\r\n %s %s  |\r\n      |\r\n========="
    print(string.format(gallow, head,larm,torso,rarm,lleg,rleg))
    print(word)
end

local function random_word()
    dictionary = {"ant", "babboon", "badger", "bat", "bear", "beaver", "camel", "cat", "clam", "cobra",
    "cougar", "coyote", "crow", "deer", "dog", "donkey", "duck", "eagle", "ferret", "fox",
    "frog", "goat", "goose", "hawk", "lion", "lizard", "llama", "mole", "rat", "raven",
    "rhino", "shark", "sheep", "spider", "toad", "turkey", "turtle", "wolf", "wombat", "zebra"}

    math.randomseed(os.time()) 
    return dictionary[math.random() and math.random(#dictionary)]
end

hp = 6
goal = random_word()
word = string.rep("_", string.len(goal))
used_letters = {}
already_used_char = ''

while hp > 0
do
    display_game(hp, word, already_used_char, used_letters)
    input_char = get_player_character()
    if input_char == " "
    then
        goto continue
    elseif array_contains(used_letters, input_char)
    then
        already_used_char = input_char
        goto continue
    end

    already_used_char = " "

    table.insert(used_letters, input_char)
    if string_contains(goal, input_char)
    then
        for i = 1, #goal
        do
            if string.sub(goal, i, i) == input_char
            then
                if i == 1
                then
                    word = replace_char(word, string.upper(input_char), i)
                else
                    word = replace_char(word, input_char, i)
                end
            end
        end
    else
        print(string.format("%s does not contain %s", goal, input_char))
        hp = hp - 1
    end

    if string.lower(word) == goal
    then
        os.execute("cls")
        print(string.format("You saved John! The word was %s", word))
        print(" O\r\n/|\\\r\n/ \\")
        break
    end

    ::continue::
end

if hp == 0
then
    print("John died!")
    display_game(hp, word, already_used_char, used_letters)
end
