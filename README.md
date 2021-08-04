# MyVocabularyTeacher
## Description

MyVocabularyTeacher is an app for English learners that allows them to increase their vocabulary through small games and the presentation of definitions.

---

## Usage

In order to use the app make sure to have the next dependencies installed:

- terminal-table ([https://rubygems.org/gems/terminal-table](https://rubygems.org/gems/terminal-table/versions/3.0.1))
- csv ([https://rubygems.org/gems/csv](https://rubygems.org/gems/csv))
- nokogiri -v 1.8.0 ([https://rubygems.org/gems/nokogiri/versions/1.8.0-x64-mingw32](https://rubygems.org/gems/nokogiri/versions/1.8.0-x64-mingw32))

To start the app run it normally as:

`ruby myvocabteacher.rb`

Or pass one or more words to look for definitions right from the start:

`ruby myvocabteacher.rb first_word second_word ... n_word`

The app will prompt for an option from the main menu:

- `search`: search for the definition of a new word
- `add`: add new words to the vocab file (saved as a CSV)
- `practice`: start a new game that will bring 5 random words from vocab file and add 5 new random words
- `exit`: close the app

### `search first_word second_word ... n_word`

This option will be executed automatically when the application starts if arguments are passed at run
The search result will always bring only the most relevant definition for each use of the word

This command will make a request to the dictionary and show a table for each result

## `add`

This command will display a table with all the words learned that hasn't been saved yet and will prompt a menu to manage the list of words

The app will prompt for an option from the add menu:

- `save`: create new vocab file if doesn't exist or update an existing one
- `delete`: remove a word or words from the list by their id
- `back`: return to the main menu

## `practice`

The app will prompt for an option from the practice menu:

- `start`: play the game to practice definitions. 10 definitions will be presented, 1 answer must be chosen for each definition (multiple choice options)
- `back`: return to main menu

---

## Dictionary

This app makes use of the results provided by [WordReference.com](https://www.wordreference.com/)

---

## Team

- [Andres Scribani](https://github.com/scribani)
- [David Ortiz](https://github.com/dortizp)
- [Nat Linares](https://github.com/natlines1492)
