
def get_player_character
    input = gets.chomp
    if input.length != 1
        puts "Invalid length"
        return " "
    end
    return input
end

def display_game(hp, word, already_used_char, used_letters)
    Gem.win_platform? ? (system "cls") : (system "clear")

    puts "John Ruby is a bad man and is on the hook! Can you save him."

    if already_used_char != ' '
        puts "Already guessed: #{already_used_char}"
    end

    if used_letters.length > 0
        puts used_letters.join(' ') + " already used."
    end

    puts "    +---+
    |   |
    #{(hp <= 5 ? "O" : " ")}   |
   #{(hp <= 3 ? "/" : " ")}#{(hp <= 4 ? "|" : " ")}#{(hp <= 2 ? "\\" : " ")}  |
   #{(hp <= 1 ? "/" : " ")} #{(hp <= 0 ? "\\" : " ")}  |
        |
  ========="
  puts word
end

def random_word
    dictionary = ["ant", "babboon", "badger", "bat", "bear", "beaver", "camel", "cat", "clam", "cobra",
    "cougar", "coyote", "crow", "deer", "dog", "donkey", "duck", "eagle", "ferret", "fox",
    "frog", "goat", "goose", "hawk", "lion", "lizard", "llama", "mole", "rat", "raven",
    "rhino", "shark", "sheep", "spider", "toad", "turkey", "turtle", "wolf", "wombat", "zebra"]
    dictionary[rand(dictionary.length)]
end

hp = 6
goal = random_word
word = "".ljust(goal.length, '_')
used_letters = []
already_used_char = ' '

while hp > 0
    display_game(hp, word, already_used_char, used_letters)

    input_char = get_player_character
    if input_char == " "
        next
    elsif used_letters.include? input_char
        already_used_char = input_char
        next
    end
    
    already_used_char = ' '

    used_letters.append(input_char)
    if goal.include? input_char
        for i in 0..(goal.length)
            if goal[i] == input_char
                word[i] = i == 0 ? input_char.capitalize() : input_char
            end
        end
    else
        hp -= 1
    end

    if word.downcase == goal
        Gem.win_platform? ? (system "cls") : (system "clear")
        puts "You saved John! The word was #{word}."
        puts " O\r\n/|\\\r\n/ \\"
        return
    end
end

puts "John died!"
display_game(0, word, already_used_char, used_letters)
