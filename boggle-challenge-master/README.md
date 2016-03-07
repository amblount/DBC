# Modeling the Game Boggle

##Summary
We're going to model the game of [Boggle][Boggle on Wikipedia]—it's a game with few rules, but there are some subtleties, so read up on it if it's at all unfamiliar. To model the whole Boggle system, we'll break it down into smaller, more manageable pieces.

This challenge covers two main concepts: algorithms and organizing code.  As we write our solution, we'll be writing a few different algorithms. For example, we'll have to determine how to populate our boards with letters, and we'll have to devise a way to search our boards for words.

We'll also be deliberate about how we organize our code—this challenge assumes that we're aware of how to write a Ruby class. We're going to build a number of small classes that are designed to have a single responsibility; in other words, each class will do one thing in our application. All of these small classes will cooperate with each other to build the entire Boggle system.

In addition, we'll continue to practice concepts and skills that we've covered at DBC. We'll practice coding to a specification; Boggle has real-life rules that we need to translate into code. We'll follow tests to give us confidence that our code is working the way we expect. And, we'll continue working with Ruby core classes, like strings and arrays.

### Testing with Test Doubles
In our applications, different types of objects need to work together.  In this challenge we're going to write both a `Die` class and a `BoggleBoard` class.  An instance of `BoggleBoard` will have a collection of `Die` objects with which it will interact. Specifically, `BoggleBoard` objects will call methods on `Die` objects and expect certain return values.

One type of object relying on another can cause problems during testing.  If a test for `BoggleBoard` is failing, is the cause of the failure in the `BoggleBoard` class itself, or are its dice not working properly?

```ruby
fake_die = double("a die", { :roll => "A" })

fake_die.roll
# => "A"
```
*Figure 1*. Creating a test double to stand in for a real `Die` object.

When we test a class, we want to test it in isolation.  In testing `BoggleBoard`, we don't want to worry about whether or not the `Die` class is working properly.  So, we can create test double objects that behave like real dice.  In Figure 1, we create a test double that behaves like a `Die` object. We can roll it, and it will return a one-character string—just like a real die, only that the test double always returns "A".


##Releases
### Release 0: A Boggle Die

```ruby
die = Die.new("ABCDEF")

die.sides
# => "ABCDEF"

die.roll
# => "B"

die.roll
# => "E"
```
*Figure 2*. Creating and using an instance of the `Die` class.

We're going to start building our Boggle system by designing the dice.  In the real world, Boggle dice have six sides with a letter appearing on each side.  We roll the dice to see which letters will make up the board.

We'll model the real-world Boggle die by creating a `Die` class.  When we create a new instance of the `Die` class, we'll pass in a six-character string; the string's characters represent the letters on the sides of the die.  Each die will have two behaviors.  When we call `#sides` on the new die object, it returns a string representing it's sides.  When we call `#roll` on the new die object, it will return one of its sides.  (see Figure 2)

We'll need to decide how our `Die` objects store the data representing its letters.  We create new dice by passing in a six-character string.  Do we want to store the string itself?  Do we want to use another data type like an array or a hash?  Which data structure makes the most sense? Additionally, we need to decide how to select which character to return when our dice are rolled.

The decisions we make affect the internal workings of the die object—in other words, how a die does its job. It doesn't matter to the rest of our system how a die represents its sides or determines which letter to return when it's rolled. The rest of the system only depends on being able to create a new instance of `Die` by passing in a six-character string and being able to roll a die and get its sides.

We'll write our `Die` class in the `die.rb` file. Tests are provided in the `spec/die_spec.rb` file.


### Release 1: The Official Boggle Dice
```ruby
dice = DiceFactory.official_boggle_dice
# => [#<Die:0x007fdcaba033b0>, #<Die:0x007fdcaba03388>, ...]
```
*Figure 3*. Creating a collection of official Boggle dice.

In Release 0, we created a `Die` class that allows us to create a die with any characters we want.  In the real world, however, Boggle is played with a specific set of dice.  We need to model those real-world dice, and we're going to build an object to create them for us. We're going to write a module named `DiceFactory`.  There are multiple ways to use Ruby modules, but we'll use this module as an object that performs a task for us.

Some of our `DiceFactory` module has already been written in the `dice_factory.rb` file. There we'll see that the module has been defined. And within the module, a constant has been defined, `OFFICIAL_DICE_LETTER_COMBINATIONS`.  This constant is an array that contains 16 six-character strings; each string represents one of the official Boggle dice.

The method `.official_boggle_dice` has already been defined for us.  But, it's empty, and we need to update the method so that it returns a collection of objects that represent the official Boggle dice (see Figure 3).  Tests have been written in `spec/dice_factory_spec.rb` to help guide developing the method.

*Note*:  With regard to *Q*, we are deviating from the real-world Boggle dice.  On the real-world Boggle dice, a *Q* is always shown as *Qu*.  We'll deal with this discrepancy when we get to displaying a board.


### Release 2: A Boggle Board
```ruby
dice = DiceFactory.official_boggle_dice
boggle_board = BoggleBoard.new(dice)

boggle_board.dice
# => [#<Die:0x007fdcaba033b0>, #<Die:0x007fdcaba03388>, ...]

boggle_board.board
# => [['A', 'R', 'O', 'O'], ['H', 'C', 'D', 'S'], ['E', 'C', 'M', 'N'], ['G', 'F', 'Z', 'I']]
```
*Figure 4*. Creating a Boggle board with a set of dice.

Now that we can create a set of Boggle dice, let's create a Boggle board to use those dice.  We'll be writing another class:  `BoggleBoard`.  We'll start off by creating the ability to make a new Boggle board object with a collection of dice and a board.  Worth noting is that when we create a Boggle board instance, we're going to give the new board its dice; the board doesn't need to know how to make it's own. (see Figure 4)

```
$ rspec --tag new_boggle_board
```
*Figure 5*.  Running just the tests for a new Boggle board.

We'll write our `BoggleBoard` class in the file `boggle_board.rb`.  Tests have been written in `spec/boggle_board_spec.rb`.  In addition, the tests for the behaviors described in this release have been *tagged* `new_boggle_board`, and we can run just these tests (see Figure 5).


### Release 3: Shaking a Boggle Board
```ruby
dice = DiceFactory.official_boggle_dice
boggle_board = BoggleBoard.new(dice)

boggle_board.shake
boggle_board.board
# => [['A', 'R', 'O', 'O'], ['H', 'C', 'D', 'S'], ['E', 'C', 'M', 'N'], ['G', 'F', 'Z', 'I']]

boggle_board.shake
boggle_board.board
# => [['X', 'L', 'A', 'E'], ['I', 'N', 'O', 'Y'], ['S', 'S', 'O', 'W'], ['J', 'A', 'R', 'E']]
```
*Figure 6*.  Shaking a Boggle board changes the board.

We're going to continue building our `BoggleBoard` class.  So far, our board has a set of dice and a blank board.  In order to play a game of Boggle, rather than having a blank board, we need a board made up of letters from the dice.

We need to model the act of shaking up a Boggle board. Let's think carefully about how shaking a real-world Boggle board works. The board has 16 cells and 16 dice. Each die lands in one and only one cell, with one side facing up.  If we shake the board again, the dice are generally in new positions with new sides facing up.

We'll add a `#shake` method to the `BoggleBoard` class that changes the state of the board by rolling each die and mixing up the order of the dice (see Figure 6).  Tests for the shaking behavior have been tagged `shake`.

After passing the tests tagged `shake`, all of the tests in `spec/boggle_board_spec.rb` should pass.  Let's run all of these tests to confirm that when adding the shake behavior, we didn't unintentionally break anything.


### Release 4: Displaying a Board on the Command Line
```ruby
dice = DiceFactory.official_boggle_dice
boggle_board = BoggleBoard.new(dice)
boggle_board.shake

puts boggle_board
# this prints: #<BoggleBoard:0x007fb321a8d5a0>

board_presenter = CommandLineBoardPresenter.new(boggle_board)
puts board_presenter
# this prints:
# E  K  R  S
# T  E  B  N
# Qu C  L  U
# O  T  G  H
```
*Figure 7*. Using a presenter class to display a board.

Now that we have a functioning board, we want to display that board to users. A `BoggleBoard` instance is responsible for its own board.  When we print an instance of `BoggleBoard` to the command line, we need to translate its board to a string with a particular format.

Taking a `BoggleBoard` instance's board and turning it into a string is a distinct responsibility, and we'll write a new class that is responsible for this behavior.  We'll build a [presenter class] whose responsibility is to take an instance of our `BoggleBoard` class and make it presentable on the command line (see Figure 7).

As we've said, our presenter will take a board and transform it *to a string*.  Is the `#to_s` method familiar?  The `#to_s` method is called on an object and returns a string representing that object.

`#to_s` has a special relationship with the `#puts` method.  When we call `#puts`, we usually pass an object as an argument—for example, `puts some_object`. When we call `#puts`, text is printed on the command line. How does Ruby know what text to print? The text that gets printed is the string returned by the argument's `#to_s` method. Therefore, we can control how an object is printed to the command line by customizing its `#to_s` method.

Our presenter class will be called `CommandLineBoardPresenter`.  We'll initialize a new instance of this class, giving it an instance of `BoggleBoard`.  We'll define a `#to_s` method for our presenter which formats the presenter's board object as a string.

Some tests are provided in the file `spec/command_line_board_presenter_spec.rb`.  One test is pending, and we'll need to write it ourselves.  This pending test describes the exact format of the string returned by `#to_s`.  Writing this test means we'll have to figure out exactly what we want a board to look like as a string.  Where are the newline characters?  How do we want to control spacing?

### Release 5: Finding Words with Simplified Rules
```ruby
dice = DiceFactory.official_boggle_dice
boggle_board = BoggleBoard.new(dice)
boggle_board.shake
boggle_board.board
# => [['H', 'A', 'N', 'D'], ['E', 'C', 'D', 'S'], ['N', 'C', 'M', 'N'], ['G', 'F', 'Z', 'I']]

finder = SimpleFinder.new(boggle_board)

finder.include?("hand")
# => true

finder.include?("rockets")
# => false
```
*Figure 8*. Using a finder with simplified rules to check words on a board.

Now it's time to check whether a word can be found on a board.  Similar to building our presenter class, we're going to build a new class that is responsible for determining whether or not a word can be found on a given board (see Figure 8).

We'll begin finding words using a simplified set of rules.  We'll continue to only count words that have at least three letters. But, whereas in real-world Boggle where we can snake around the board to find words, we're only going to count words that appear in a straight line.  This could be in a row, in a column, diagonally, forward, or backward.  But, always in a straight line.

Also, remember that we'll have to deal with the fact that a *Q* in our board is a stand in for *Qu*.

Some tests are provided in the file `spec/simple_finder_spec.rb`. All but one of the tests are pending.  Some of the pending tests have been written but marked as pending (i.e., defined with `xit` instead of `it`).  Some of the tests are pending because they have not been provided a block—we'll have to write those tests ourselves.

Begin by making the first test pass.  Then, move one-by-one through each of the pending tests.


### Release 6: Finding Words with the Official Rules
```ruby
dice = DiceFactory.official_boggle_dice
boggle_board = BoggleBoard.new(dice)
boggle_board.shake
boggle_board.board
# => [['H', 'A', 'R', 'B'], ['E', 'C', 'D', 'O'], ['N', 'C', 'M', 'N'], ['G', 'F', 'Z', 'I']]

finder = OfficialFinder.new(boggle_board)

finder.include?("hard")
# => true

finder.include?("harbor")
# => false
```
*Figure 9*. Using a finder with the official rules to check words on a board.

We've written an algorithm to find words on a board using a simplified set of rules.  Now it's time to use the real Boggle rules to find words—we can snake all around the board to trace the letters spelling a word.  We just need to make sure that we don't use the same letter twice. (see Figure 9)

We're not going to modify our `SimpleFinder`.  Instead, we'll create another class `OfficialFinder`.  This way we can sometimes use one and sometimes use the other.  Each of our finders will implement the `#include?` method for finding words, so we can use both of them in the same way. But the algorithm that each uses to search a board will be different.

Only one test has been provided for this release; see the file `spec/official_finder_spec.rb`.  We'll need to write the rest of the tests as we go, keeping in mind starting with simple examples and building up to more complex examples, testing for edge cases, and following the red-green-refactor cycle.


### Release 7: Put the Pieces Together
At this point we have all the pieces in place for interacting with a Boggle board on the command line; we can build dice, build a board, shake a board, format a board for display, and determine whether or not a word is on the board.  

Let's put these pieces together to build an interactive command-line application that will show users a Boggle board and allow the users to check for words on the board.  Add your code to the `runner.rb` file, which is setup to require all of the files that we've been writing.


## Conclusion
We've covered a lot of ground in this challenge.  The releases guided us to writing code in an object-oriented style—we'll be learning more about object-oriented design going forward.  We've written a number of small classes, each of which does one thing.  These classes were dictated to us, but going forward we're going to need to determine what types of objects we need on our own.

Another major portion of this challenge was writing algorithms.  We've had to write algorithms for creating a set of dice, for converting a board—a nested array—into a string, and for finding a word on a board.  If we've struggled to write any of these algorithms or were unable to complete any of them, we should come back to this challenge and practice until we feel comfortable completing the challenge.




[presenter class]: https://robots.thoughtbot.com/decorators-compared-to-strategies-composites-and
[Boggle on Wikipedia]: http://en.wikipedia.org/wiki/Boggle
