Imports System
Imports System.Text

Module Hangman
    Sub Main()
        Dim hp = 6
        Dim goal = RandomWord()
        Dim word = New StringBuilder("".PadLeft(Goal.Length, "_"))
        Dim usedLetters = new List(Of Char)
        Dim alreadyUsedChar As Char

        Do
            DisplayGame(hp, word.ToString(), alreadyUsedChar, usedLetters.ToArray())

            Dim inputChar = GetPlayerCharacter()
            If inputChar = Char.MinValue Then
                Continue Do
            Else If (usedLetters.Contains(inputChar)) Then
                alreadyUsedChar = inputChar
                Continue Do
            End If

            alreadyUsedChar = Char.MinValue

            usedLetters.Add(inputChar)
            If Not goal.Contains(inputChar) Then
                hp -= 1
            Else
                For i = 0 To goal.Length -1
                    If goal(i) = inputChar Then
                        word(i) = If(i = 0, char.ToUpper(inputChar), inputChar)
                    End If
                Next
            End If

            If word.ToString().ToLower() = goal
                Console.Clear()
                Console.WriteLine($"You saved John! The word was {word}.")
                Console.WriteLine($" O{Environment.NewLine}/|\{Environment.NewLine}/ \")
                return
            End If
        Loop While (hp > 0)

        Console.WriteLine("John died!")
        DisplayGame(hp, word.ToString(), alreadyUsedChar, usedLetters.ToArray())
    End Sub

    Sub DisplayGame(hp As Integer, word As String, alreadyUsedChar As Char, usedLetters As Char())
        Console.Clear()
        Console.WriteLine("John Longneck is a bad man and is on the hook! Can you save him.")

        If (alreadyUsedChar <> Char.MinValue) Then
            Console.WriteLine($"Already guessed: {alreadyUsedChar}")
        End If

        If (usedLetters.Length > 0) Then
            Console.WriteLine($"Used letters: {String.Join("", UsedLetters)}")
        End If

        Console.WriteLine($"
  +---+
  |   |
  {If(hp <= 5, "O", " ")}   |
 {If(hp <= 3, "/", " ")}{If(hp <= 4, "|", " ")}{If(hp <= 2, "\", " ")}  |
 {If(hp <= 1, "/", " ")} {If(hp <= 0, "\", " ")}  |
      |
=========")
        Console.WriteLine(word)
    End Sub

    Function GetPlayerCharacter() As Char
        Dim input As String

        input = Console.ReadLine()
        If input.Length <> 1 Then
            Console.WriteLine("Invalid input length")
            return char.MinValue
        End IF

        return input.ToLower()(0)
    End Function

    Function RandomWord() As String
        Dim dictionary() As String = {"ant", "babboon", "badger", "bat", "bear", "beaver", "camel", "cat", "clam", "cobra",
        "cougar", "coyote", "crow", "deer", "dog", "donkey", "duck", "eagle", "ferret", "fox",
        "frog", "goat", "goose", "hawk", "lion", "lizard", "llama", "mole", "rat", "raven",
        "rhino", "shark", "sheep", "spider", "toad", "turkey", "turtle", "wolf", "wombat", "zebra"}
        return dictionary(new Random().Next(0, dictionary.Length))
    End Function
End Module
