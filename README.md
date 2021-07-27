# MyVocabularyTeacher
## Description

MyVocabularyTeacher is an app for English or Spanish learners that allows them to increase their vocabulary through small games and the presentation of definitions.

## Usage

In order to use the app you need to make sure you have the next dependencies installed in your system or enviroment:

- terminal-table ([https://rubygems.org/gems/terminal-table](https://rubygems.org/gems/terminal-table/versions/3.0.1))
- csv ([https://rubygems.org/gems/csv](https://rubygems.org/gems/csv))
- httparty ([https://rubygems.org/gems/httparty](https://rubygems.org/gems/httparty))

To start the app you can run it normally as:

`ruby myvocabteacher.rb`

Or you can also pass one or more words to look for definitions right from the start (you can also provide the language -default is English-):

`ruby myvocabteacher.rb first_word second_word ... n_word spanish`

The app will prompt you for an option from the list of options:

- `search`: searches for the definition of a new word
- `add`: adds new word to my vocab list (this list will be saved as a CSV file)
- `practice`: starts a new game that will bring 5 random words from your dictionary and add 5 new random words for you to learn
- `toogle`: changes the current language for the alternative (between English and Spanish)
- `exit`: closes the app

The app will show: 

- Word (in search option)
- Definition (in search option)
- Example (in search option)
- The app will ask the user name. If the is not found, it will create a new file, if not it will append to the existing user file (in add option)
- The app will pick 3 random words to practice from the server (in practice option)
- The app will pick words from the user dictionary (max 7) (in practice option)
- The app will show a random definition from the list that contains new words and user dictionary (in practice option)
- The app will show possible answers as multiple choice (in practice option)
- Each correct answer will be valued in 10 points (in practice option)
- After finishing the app will prompt the user for his/her name and update the scores.json file if the user wants to save the score (in practice option)

## API

This app makes use of the Free Dictionary API ([https://dictionaryapi.dev/](https://dictionaryapi.dev/))

## Team

- Andres Scribani
- David Ortiz
- Nat Linares
