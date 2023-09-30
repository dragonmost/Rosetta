using System.Text;

int HP = 6;
string Goal = RandomWord();
StringBuilder Word = new StringBuilder("".PadRight(Goal.Length, '_'));
List<char> UsedLetters = new();
char alreadyUsedChar = ' ';

while (HP > 0)
{
    DisplayGame(HP, Word.ToString(), alreadyUsedChar, UsedLetters.ToArray());

    char inputChar = GetPlayerCharacter();
    if (inputChar == char.MinValue)
    {
        continue;
    }
    else if (UsedLetters.Contains(inputChar))
    {
        alreadyUsedChar = inputChar;
        continue;
    }

    alreadyUsedChar = ' ';

    UsedLetters.Add(inputChar);
    if (!Goal.Contains(inputChar))
    {
        HP--;
    }
    else
    {
        for (int i = 0; i < Goal.Length; i++)
        {
            if (Goal[i] == inputChar)
            {
                Word[i] = i == 0 ? char.ToUpper(inputChar) : inputChar;
            }
        }
    }

    if (Word.ToString().ToLower() == Goal)
    {
        Console.Clear();
        Console.WriteLine($"You saved John! The word was {Word}.");
        Console.WriteLine(" O\r\n/|\\\r\n/ \\");
        return;
    }
}

Console.WriteLine("John died!");
DisplayGame(HP, Word.ToString(), alreadyUsedChar, UsedLetters.ToArray());

char GetPlayerCharacter()
{
    string input = Console.ReadLine();

    if(input?.Length != 1)
    {
        Console.WriteLine("Invalid input length");
        return char.MinValue;
    }

    return input.ToLower()[0];
}

void DisplayGame(int hp, string word, char alreadyUsedChar, char[] usedLetters)
{
    Console.Clear();

    Console.WriteLine("John Microsoft is a bad man and is on the hook! Can you save him.");

    if(alreadyUsedChar != ' ')
    {
        Console.WriteLine($"Already guessed: {alreadyUsedChar}");
    }

    if(usedLetters.Length > 0)
    {
        Console.WriteLine($"Used letters: {string.Join("", UsedLetters)}");
    }

    Console.WriteLine(@$"
  +---+
  |   |
  {(hp <= 5 ? "O" : " ")}   |
 {(hp <= 3 ? "/" : " ")}{(hp <= 4 ? "|" : " ")}{(hp <= 2 ? "\\" : " ")}  |
 {(hp <= 1 ? "/" : " ")} {(hp <= 0 ? "\\" : " ")}  |
      |
=========");
    Console.WriteLine(word);
}

string RandomWord()
{
    string[] dictionary = new string[] {"ant", "babboon", "badger", "bat", "bear", "beaver", "camel", "cat", "clam", "cobra",
    "cougar", "coyote", "crow", "deer", "dog", "donkey", "duck", "eagle", "ferret", "fox",
    "frog", "goat", "goose", "hawk", "lion", "lizard", "llama", "mole", "rat", "raven",
    "rhino", "shark", "sheep", "spider", "toad", "turkey", "turtle", "wolf", "wombat", "zebra"};
    return dictionary[new Random().Next(0, dictionary.Length)];
}

/*
  +---+
  |   |
  O   |
 /|\  |
 / \  |
      |
=========
*/
