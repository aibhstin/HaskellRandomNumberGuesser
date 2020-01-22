# RandomGuesser
## Intention
The intention of this program was to get experience in building a real Haskell application. I chose the simple, 
ubiquitous random-number guessing game as it is conceptually simple yet requires use of several key IO concepts, 
such as generating a randon number, accepting user input, validating user input, and handling different cases of user input. 

## What I Think Went Well
Using Haskell's algebraic and parameterized datatypes made signalling and handling different cases of user input much easier. I defined the following datatype:

    data InputType a =
        InvalidInput
      | IncorrectGuess Int
      | CorrectGuess
     
This datatype efficiently alows for program state to be handled in a functional manner. Wrapping an 'Int' in the
'IncorrectGuess' data constructor then allows further comparison to be performed to give the user a hint on whether
their answer was too low or too high. This practical use of Haskell's ADTs illuminated fully for the first time to me the 
utility of ADT's in modelling a problem domain.

## What I Could Improve
The most glaring problem in this program is in the generation of the initial random number, specifically in the use of

    randomNumber = unsafePerformIO $ randomRIO (1, 100)
    
The function 'unsafePerformIO', imported from 'System.IO.Unsafe', essentially 'pulls out' the int from the IO monad returned 
by randomRIO. In almost every case, 'unsafePerformIO' should absolutely be avoided. It implies a promise by the programmer 
to the compiler that the function is verifiably pure. My semi-justification for using it here is that, whilst the number 
returned will be different each time (And is therefore impure), it will remain constant throughout the lifetime of the program. 
Put another way, as the random number is generated only once, it can be treated almost as though it were a hard-coded constant 
value.

Nevertheless, the use of 'unsafePerformIO' is still something to be avoided. I could improve this program by rewriting it to 
work **with** the IO monad, instead of against it. I will work on an improved version soon, making use of 'return', the IO monad, and the 'do... ->' syntax to wipe out the need for 'unsafePerformIO'.
