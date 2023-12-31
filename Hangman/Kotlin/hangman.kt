fun main() {
    var hp = 6
    val goal = randomWord()
    var word = StringBuilder().append("".padStart(goal.length, '_'))
    val usedLetters: MutableList<Char> = ArrayList()
    var alreadyUsedChar = ' '

    while (hp > 0) {
        displayGame(hp, word, alreadyUsedChar, usedLetters)

        val inputChar = getPlayerCharacter()
        if (inputChar == ' ') {
            continue
        } else if (usedLetters.contains(inputChar)) {
            alreadyUsedChar = inputChar
            continue
        }

        alreadyUsedChar = ' '

        usedLetters.add(inputChar)
        if (!goal.contains(inputChar)){
            hp--
        } else {
            for (i in (0..goal.length -1)) {
                if (goal[i] == inputChar) {
                    if (i == 0) word.set(i, inputChar.uppercaseChar()) else word.set(i, inputChar)
                }
            }
        }

        if (word.toString().lowercase() == goal) {
            print("\u001b[H\u001b[2J")
            println("You saved John! The word was ${word}")
            println(" O\r\n/|\\\r\n/ \\")
            return
        }
    }

    println("John died!")
    displayGame(0, word, alreadyUsedChar, usedLetters)
}

fun randomWord(): String  {
    val dictionary = arrayOf("ant", "babboon", "badger", "bat", "bear", "beaver", "camel", "cat", "clam", "cobra",
    "cougar", "coyote", "crow", "deer", "dog", "donkey", "duck", "eagle", "ferret", "fox",
    "frog", "goat", "goose", "hawk", "lion", "lizard", "llama", "mole", "rat", "raven",
    "rhino", "shark", "sheep", "spider", "toad", "turkey", "turtle", "wolf", "wombat", "zebra")
    return dictionary[(0..dictionary.size -1).random()]
}

fun displayGame(hp: Int, word: StringBuilder, alreadyUsedChar: Char, usedLetters: MutableList<Char>) {
    print("\u001b[H\u001b[2J")

    println("John Kotlin is a bad man and is on the hook! Can you save him.")

    if (alreadyUsedChar != ' ') {
        println("Already guessed: $alreadyUsedChar")
    }

    if (usedLetters.count() > 0) {
        println("Used letters: ${usedLetters.joinToString(" ")}")
    }
    
    var head = " "
    var torso = " "
    var larm = " "
    var rarm = " "
    var lleg = " "
    var rleg = " "
    
    if (hp <= 5)
        head = "O"
    if (hp <= 4)
        torso = "|"
    if (hp <= 3)
        larm = "/"
    if (hp <= 2)
        rarm = "\\"
    if (hp <= 1)
        lleg = "/"
    if (hp <= 0)
        rleg = "\\"

    println("  +---+\r\n  |   |\r\n  $head   |\r\n $larm$torso$rarm  |\r\n $lleg $rleg  |\r\n      |\r\n=========")   
    println(word)
}

fun getPlayerCharacter(): Char {
    val input = readLine()!!
    if (input.length != 1) {
        println("Invalid length")
        return ' '
    }

    return input.lowercase().first()
}
