/* REXX */
say "I'm thinking of a number between 1 and 10."
secret = RANDOM(1,10)
tries = 1

do while (guess \= secret)
    say "What is your guess? enter Q to quit"
    pull guess

    if (guess = 'Q') then
     do
     tries = 'to "Quit"'
     leave
     end

    if (DATATYPE(guess,'N') = 0) then
     say "This is not even an number! come on..."

    if (DATATYPE(guess,'W') = 0) then
    do
     say "Enter whole number only..."
    end

    if (guess < 0) | (guess > 10) then
    do
        say "Enter something betwen 0 to 10 only"
    end

    if (guess \= secret) then
    do
        say "That's not it. Try again"
        tries = tries + 1
    end
end
say "You got it! And it only took you" tries "tries!"
exit
