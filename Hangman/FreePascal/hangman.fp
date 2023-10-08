program hangman;
uses
    Classes, crt, SysUtils;

var
    hp, usedLettersIndex, i : integer;
    goal, currentProgress, inputString : string;
    usedLetters : array [0..25] of char;
    alreadyUsedChar : char;

    function GetPlayerCharacter(): char;
    var
        inputChar : string;
    begin
        readln(inputChar);

        if Length(inputChar) <> 1 then
        begin
            writeln('Invalid input length');
            Exit(' ');
        end;

        Exit(inputChar[1]);
    end;

    function RandomWord(): string;
    const
        dictionary : Array [69..108] of String = ('ant', 'babboon', 'badger', 'bat', 'bear', 'beaver', 'camel', 'cat', 'clam', 'cobra',
        'cougar', 'coyote', 'crow', 'deer', 'dog', 'donkey', 'duck', 'eagle', 'ferret', 'fox',
        'frog', 'goat', 'goose', 'hawk', 'lion', 'lizard', 'llama', 'mole', 'rat', 'raven',
        'rhino', 'shark', 'sheep', 'spider', 'toad', 'turkey', 'turtle', 'wolf', 'wombat', 'zebra');
    begin
        Randomize;
        Exit(dictionary[Random(40) + 69]);
    end;

    procedure DisplayGame (hp : integer; currentProgress : string; alreadyUsedChar : char; usedChar : array of char);
    var
        usedLetters : string;
        head, larm, torso, rarm, lleg, rleg : string;
    begin
        ClrScr;
        writeln('Pascal Freeman is a bad man and is on the hook! Can you save him.');

        if alreadyUsedChar <> ' ' then
        begin
            writeln(Format('Already guessed: %s', [alreadyUsedChar]));
        end;

        if Length(usedChar) > 0 then
        begin
            usedLetters := Concat(usedChar);
            writeln(Format('Used letters: %s', [usedLetters]));
        end;

        if hp <= 5 then
            head := 'O'
        else
            head := ' ';

        if hp <= 4 then
            larm := '/'
        else
            larm := ' ';

        if hp <= 3 then
            torso := '|'
        else
            torso := ' ';

        if hp <= 2 then
            rarm := '\'
        else
            rarm := ' ';

        if hp <= 1 then
            lleg := '/'
        else
            lleg := ' ';

        if hp <= 0 then
            rleg := '\'
        else
            rleg := ' ';

        writeln(Format('  +---+'#13#10'  |   |'#13#10'  %s   |'#13#10' %s%s%s  |'#13#10' %s %s  |'#13#10'      |'#13#10'=========', [head, larm, torso, rarm, lleg, rleg]));
        writeln(currentProgress);
    end;

    function ArrayContains(list : array of char; value : char): boolean;
    var
        i: Integer;
    begin
        for i := Low(list) to High(list) do
        begin
            if list[i] = value then
            begin
                exit(true)
            end;
        end;
        exit(false);
    end;

    function StringContains(list : string; value : char): boolean;
    var
        i: Integer;
    begin
        for i := 1 to Length(list) do
        begin
            if list[i] = value then
            begin
                exit(true)
            end;
        end;
        exit(false);
    end;

    procedure DisplayCharArray(myArray : array of char);
    var
        i: Integer;
    begin
        for i := Low(myArray) to High(myArray) do
            writeln(myArray[i]);
    end;

    const
        dictionary : Array [0..1] of char = ('a', 'b');
begin
    hp := 6;
    goal := RandomWord();
    usedLettersIndex := 0;

    currentProgress := StringOfChar('_', Length(goal));
    FillChar(usedLetters, SizeOf(usedLetters), ' ');
    alreadyUsedChar := ' ';

    while (hp > 0) do
    begin
        DisplayGame(hp, currentProgress, alreadyUsedChar, usedLetters);
        inputString := GetPlayerCharacter();

        if inputString = ' ' then
        begin
            Continue;
        end
        else if ArrayContains(usedLetters, inputString[1]) then
        begin
            alreadyUsedChar := inputString[1];
            Continue;
        end;

        alreadyUsedChar := ' ';

        usedLetters[usedLettersIndex] := inputString[1];
        Inc(usedLettersIndex);

        if not StringContains(goal, inputString[1]) then
        begin
            Dec(hp);
        end
        else
        begin
            for i := 1 to Length(goal) do
            begin
                if goal[i] = inputString[1] then
                begin
                    if i = 1 then
                        currentProgress[i] := UpperCase(inputString)[1]
                    else
                        currentProgress[i] := inputString[1];
                end;
            end; 
        end;

        if LowerCase(currentProgress) = goal then
        begin
            ClrScr;
            writeln(Format('You saved John! The word was %s.', [currentProgress]));
            writeln(' O'#13#10'/|\'#13#10'/ \');
            break
        end;
    end;
    
    if hp = 0 then
    begin
        writeln('John died!');
        DisplayGame(hp, currentProgress, alreadyUsedChar, usedLetters);
    end;
    
    readln();
end.
