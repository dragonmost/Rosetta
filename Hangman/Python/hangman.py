import random

def get_player_character():
    input_result = input()
    if len(input_result) != 1:
        print("Invalid length")
        return " "
    
    return input_result.lower()

def display_game(hp, word):
    if hp <= 5:
        head = "O"
    else:
        head = " "

    if hp <= 4:
        torso = "|"
    else:
        torso = " "

    if hp <= 3:
        larm = "/"
    else:
        larm = " "

    if hp <= 2:
        rarm = "\\"
    else:
        rarm = " "

    if hp <= 1:
        lleg = "/"
    else:
        lleg = " "

    if hp <= 0:
        rleg = "\\"
    else:
        rleg = " "

    gallow = "  +---+\r\n  |   |\r\n  {}   |\r\n {}{}{}  |\r\n {} {}  |\r\n      |\r\n========="
    print(gallow.format(head,larm,torso,rarm,lleg,rleg))
    print("".join(word))

def random_word():
    dictionary = ["ant", "babboon", "badger", "bat", "bear", "beaver", "camel", "cat", "clam", "cobra",
    "cougar", "coyote", "crow", "deer", "dog", "donkey", "duck", "eagle", "ferret", "fox",
    "frog", "goat", "goose", "hawk", "lion", "lizard", "llama", "mole", "rat", "raven",
    "rhino", "shark", "sheep", "spider", "toad", "turkey", "turtle", "wolf", "wombat", "zebra"]
    return random.choice(dictionary)

print("John Python is a bad man and is on the hook! Can you save him.")

hp = 6
goal = random_word()
word = "".zfill(len(goal)).replace("0", "_")
used_letters = []

while hp > 0:
    if len(used_letters) > 0:
        print("Used letters: " + ' '.join(used_letters))

    display_game(hp, word)
    input_char = get_player_character()
    if input_char == " ":
        continue
    elif input_char in used_letters:
        print(input_char + " already used.")
        continue

    used_letters.append(input_char)
    if input_char in goal:
        for i in range(len(goal)):
            if goal[i] == input_char:
                if i == 0:
                    word = word[:i] + input_char.capitalize() + word[i + 1:]
                else:
                    word = word[:i] + input_char + word[i + 1:]
    else:
        hp -= 1
    
    if word.lower() == goal:
        print("You saved John! The word was {}.".format(word))
        print(" O\r\n/|\\\r\n/ \\")
        break

if hp == 0:
    print("John died!")
    display_game(hp, word)
