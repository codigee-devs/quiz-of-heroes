# Quiz of Heroes

_Greetings, traveller! Are you brave enough to face the adventure? I warn you though, it won't be an easy one. 
You'll have to reach the heights of your knowledge to confront the great book of riddles. Luckily, you don't have to do it with your bare hands. Find powerful
artefacts that will help you in your plight. So what are you waiting for? Start the game and be the best hero in the world!_

## App Overview
Quiz of Heroes is an application made in a Flutter, which is a variation of trivia games. At first, the user has to pick a class and name its character.
After that, the first question will appear on a screen, with four potential answers. The user's task is to choose the right one. 
The more correct answers to the questions, the higher the final score. The game is over after losing all of the player's health.

## Technology stack
App is written with respecting clean architecture principles.
Main Flutter packages used in developing process are listed below:
- Firebase (remote data source, leaderboard),
- Freezed,
- BLoC (state management),
- GetIt (dependency injection),
- Dartz,
- flutter_hooks,

## File structure

App is seperated into several different folders to reflect different layers.

**/core** - Contains values and widgets used in multiple places,  
**/data** - Repositories, data sources, failures,  
**/domain** - Layer for entities and usecases,  
**/presentation** - All UI and BLoC related files. Each page has its own folder.  
