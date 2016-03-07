# Parsing Data: CSV to Ruby to CSV

## Summary
When we run our applications, Ruby objects are created that exist in our computer's memory.  These objects have state, or information, associated with them.  In-memory state is lost when our application ends, so if we want to save this state, we need to record it somewhere.

In addition to saving the state of our programs for ourselves, we sometimes want to share this information with other systems or programs.  To accomplish this, in addition to merely saving the data, we need to save it in a format that is both compatible with these other systems and easily transfered.

One common approach to saving state in an exchangeable format is to translate the information to text.  XML, JSON, CSV, and YAML are all examples of text-based data exchange formats.

In this challenge, we'll use [CSV][wikipedia csv] as our format for storing data.  We'll be representing people in Ruby as instances of the class `Person`.  We'll both build `Person` objects from data in a CSV file and also save the state of Ruby `Person` objects in a CSV file.


### Ruby's CSV Library
Ruby provides a library for working with CSV files (see [Ruby docs][ruby docs csv]).  It is part of Ruby's Standard Library, so we always have access to it.  However, as it's not part of Ruby's Core, it's not automatically loaded for us when our programs run.  We need to explicitly require it (see the top of the file `person_parser.rb`).

We'll use this CSV library to both read and write CSV files.  Take time to read through the Ruby docs on the class.  Also, the blog post *[Parsing CSV with Ruby][technical pickles csv]* might prove helpful in understanding some of the options that we can specify when reading a CSV file (e.g., specifying that the CSV file contains a row of headers).


### Lazy Initialization and Memoization
Reading and writing CSV—or another format—can be a resource-intensive operation. The file with which we'll be working contains just a couple hundred lines, so it can be read quickly.  But, imagine if it contained a couple hundred thousand lines.  Then we might notice a performance problem as reading the file could really slow down our program.

There are strategies to mitigate the costs of expensive operations like reading in a file.  Two of these are exhibited in the `PersonParser` class.

One of these strategies is *[lazy initialization][wikipedia lazy initialization]*.  With this strategy, we delay executing a costly operation until we absolutely need to do it. The `PersonParser` class translates the data in a CSV file to Ruby `Person` objects.  When we create a new instance of the class, we specify in which CSV file the data can be found, but we don't parse the file right away.   We wait to do the expensive file reading operation until we actually need the Ruby objects and call the `#people` method, which returns a collection of `Person` objects based on the data in the file.  

The other strategy used is *[memoization][wikipedia memoization]*.  In this strategy we limit the number of times that we run an expensive operation by caching the result of the operation.  In the `PersonParser` class, the first time we call the `#people` method, we parse the file and store the result of the parsing in an instance variable.  Subsequent calls to the `#people` method return the value of the instance variable.


## Releases
### Release 0: Represent People as Ruby Objects
We'll begin by creating a `Person` class; in our Ruby program, each instance of this class will represent a person.  Our person class should be designed to represent the data found in the file `people.csv`.  In other words, an instance of our `Person` class should have a first name, a last name, etc.

We'll need to write tests for our class.  What behaviors does our `Person` class need?  Let's be sure that we can ask an instance of the class for each of its attributes:  first_name, last_name, etc.


### Release 1: Parsing from CSV to Ruby
We now have a Ruby object that can hold the information contained in the `people.csv` file.  So, now we're going to actually build some `Person` objects based on the data in the file.

We're presented with an unfinished `PersonParser` class.  One behavior that is missing is the parsing of a CSV file into `Person` objects.  Write out the method body for the private `#parse_people_objects_from_file` method.  This method should return an array of `Person` objects based on the data in the CSV file.  We won't call this method directly on the object, but it will be called from within the `#people` method.

We need to test the behavior of our `PersonParser` class.  Given an instance of the class, when we call `#people` what should be returned?


### Release 2: Appropriate Data Types in Ruby
In our CSV file everything is text.  That means everything comes into our Ruby application as strings.  Sometimes this is appropriate.  For example, names, phone numbers, and e-mail addresses are represented well as strings.  In other cases, it can be beneficial to convert the CSV text into objects other than strings.

In our case, the `people.csv` file has a `created_at` field.  In the CSV file this is just a conveniently-formatted string, but in Ruby we might want it to be an instance of the `DateTime` class.  Instead of storing the created at value as a string, use the [DateTime.parse method][] to parse the value in the CSV file into a `DateTime` object.

*Note:*  Like Ruby's CSV library, the `DateTime` class is not automatically loaded when our programs run.  We need to require it:  `require 'date'`.


### Release 3: Working with the Ruby Objects
One of the advantages of loading the data from the CSV file into Ruby objects is that it becomes easier for us to filter the collection of people or to manipulate their attributes.  For example, we could order the people by first name.  Or, we could update a person's phone number.

In the file `runner.rb` we parse the code found in `people.csv` into `Person` objects.  Then we filter the list of people to see which of them have phone numbers from area code 419.  What other filtering could we do to our collection of people in the runner file?  Update the runner file to display a couple additional sortings or filterings of the people.


### Release 4: Saving Ruby State to CSV
```ruby
jane = Person.new(...)
john = Person.new(...)

parser = PersonParser.new('friends.csv')
parser.save([jane, john])
```
*Figure 1*.  Creating people in ruby and saving their data to a CSV file.

We can now take CSV data and turn it into Ruby objects which we can use in our programs.  Now we're going to take Ruby objects and save their state to a CSV file.  To do this, we want to instantiate a `PeopleParser` with the name of the file to which we want to write.  We can create a collection of `People` objects and then give them to the parser to save to the file.  (see Figure 1)

*Note:* When we read and write to a file, we can choose a mode (like `"r"` for read and `"w"` for write).  The CSV modes are the same as the [modes available for File][ruby file modes].


### Release 5: Collect and Save Information
Now that we can write data to CSV, let's write a script that will allow us to create a sort of CSV address book.  We'll enter people's names, phone numbers, etc. and then save the data to a CSV file.  Let's modify the runner file so that when it runs, we're prompted to enter information.  We'll enter the data for as many people as we want.  And then, once we're done making entries, the data we've entered will be written to a CSV file.


## Conclusion
The overall goal of this challenge is to learn to manipulate Ruby objects and CSV as part of a single application. All the data we needed to represent people was held in a CSV file, but the CSV file is just text and lacks person-like behavior (e.g., returning a name).  By creating Ruby objects based on the data, we were able to create objects whose behaviors matched the needs of our application. This is a common pattern in software engineering: change the representation of data from Format A to Format B to make it easier to do X with it.

[DateTime.parse method]: http://www.ruby-doc.org/stdlib-2.1.0/libdoc/date/rdoc/DateTime.html#method-c-parse
[ruby docs csv]: http://ruby-doc.org/stdlib-2.1.0/libdoc/csv/rdoc/CSV.html
[ruby file modes]: http://ruby-doc.org/core-2.1.0/IO.html#method-c-new-label-IO+Open+Mode
[technical pickles csv]: http://technicalpickles.com/posts/parsing-csv-with-ruby/
[wikipedia csv]: https://en.wikipedia.org/wiki/Comma-separated_values
[wikipedia lazy initialization]: https://en.wikipedia.org/wiki/Lazy_initialization
[wikipedia memoization]: https://en.wikipedia.org/wiki/Memoization
