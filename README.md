# MyVocabularyTeacher
## Description

MyVocabularyTeacher is an app for English or Spanish learners that allows them to increase their vocabulary through small games and the presentation of definitions.

---

## Usage

In order to use the app make sure to have the next dependencies installed:

- terminal-table ([https://rubygems.org/gems/terminal-table](https://rubygems.org/gems/terminal-table/versions/3.0.1))
- csv ([https://rubygems.org/gems/csv](https://rubygems.org/gems/csv))
- httparty ([https://rubygems.org/gems/httparty](https://rubygems.org/gems/httparty))

To start the app run it normally as:

`ruby myvocabteacher.rb`

Or pass one or more words to look for definitions right from the start (the language can also be provided. Default language is English):

`ruby myvocabteacher.rb first_word second_word ... n_word spanish`

The app will prompt for an option from the main menu:

- `search`: search for the definition of a new word
- `add`: add new words to the vocab file (saved as a CSV)
- `practice`: start a new game that will bring 5 random words from vocab file and add 5 new random words
- `toggle`: change the current language for the alternative (between English and Spanish)
- `exit`: close the app

### `search first_word second_word ... n_word`

This option will be executed automatically when the application starts if arguments are passed at run

This command will make a request to the **API** and show a table for each result

### `add`

This command will display a table with all the words learned that hasn't been saved yet and will prompt a menu to manage the list of words

The app will prompt for an option from the add menu:

- `delete`: remove a word from the list
- `save`: create new vocab file if doesn't exist or update an existing one
- `back`: return to the main menu

### `practice`

The app will prompt for an option from the practice menu:

- `definitions`: play the game for definitions. 10 definitions will be presented, 1 answer must be chosen for each definition (multiple choice options)
- `examples`: play the game for examples. 10 sentences will be presented, 1 answer must be chosen for each sentence (multiple choice options)
- `back`: return to main menu

---

## API

This app makes use of the Free Dictionary API ([https://dictionaryapi.dev/](https://dictionaryapi.dev/))

---

## Team

- [Andres Scribani](https://github.com/scribani)
- [David Ortiz](https://github.com/dortizp)
- [Nat Linares](https://github.com/natlines1492)