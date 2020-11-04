Group: Recipely
| Group Members	| Student Number| Contact |
| ------------- | --------- | ------------|
| David Ruiz	  | 004015588 | daruiz@csumb.edu |
| Kevin Guzman	| 004219623 | keguzman@csumb.edu |
| Mariana Duarte| 003067297 | mduarte@csumb.edu |
| Mireya Leon	  | 002954041 | mleon@csumb.edu |
 
			               	
Original App Design Project - README Template
===

# Recipely

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Users can search recipes by ingredients and store them as favorites. A user can add ingredients of a recipe to an aggregated shopping list.

### App Evaluation
- Category: Food & Drink
- Mobile: This app would be primarily developed for mobile
- Story: The user can explore recipes, favorite recipes, and create shopping lists based on recipes.
- Market: Any individual of any cooking expertise could choose to use this app.
- Habit: This app could be used as often or on occasion for culinary inspiration.
- Scope: Allow individuals to find recipes and save their favorites.


## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* 1. User can SignIn / LogOut
* 2. User can search recipes by ingredients
* 3. User can see their history of searched recipes
* 4. User can click recipe and see info about it
* 5. User can add ingredients to a shopping list from a recipe

### 2. Screen Archetypes

* Login
   * Enter a username and password
* Create Account 
   * Enter a username and password
* Search Screen
   * Users can enter ingredients in the search bar to filter recipes
* Favorites Screen
   * Users can view a stream of their favorited recipes
* Shopping List Screen
   * Users can create a shopping list of ingredients from recipes
   * Ingredients can be deleted by swiping the cell


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Recipe Search
* Favorites
* Shopping List

**Flow Navigation** (Screen to Screen)

* Login/Create account -> Search Tab Screen
* Recipe Search -> Recipe Details View

## Wireframes
https://miro.com/app/board/o9J_kh1a5c4=/

### [BONUS] Digital Wireframes & Mockups
https://miro.com/app/board/o9J_kh1a5c4=/

### [BONUS] Interactive Prototype
https://marvelapp.com/prototype/5ff7j92/screen/73854579 

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | userId        | String   | unique id for the user |
   | username      | Pointer to User| user's selected username |
   | password      | String | a user's password |
   | favorites     | Array | array of recipe ids that the user has favorited |
   | shoppingList  | Array | array of ingredient name and their respective count pairs

### Networking
- [Create basic snippets for each Parse network request] - STILL NEED TODO

- Network request to parse when logging in. (Login Screen)
- GET request to Spoonacular API to search for recipes by ingredients (Search Screen) 
- GET request to Spoonacular API to get recipe details (Recipe Details Screen)
- POST request to Spoonacular API to create a shopping list with ingredients (Recipe Details Screen) 
##### Spoonacular API
- Base URL - https://spoonacular.com/food-api

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`   | https://api.spoonacular.com/recipes/findByIngredients  | GET request to Spoonacular API to search for recipes by ingredients 
    `GET`   |  https://api.spoonacular.com/recipes/{id}/information | GET request to Spoonacular API to get recipe details (Recipe Details Screen)
    `POST`  | https://api.spoonacular.com/mealplanner/{username}/shopping-list/items| POST request to Spoonacular API to create a shopping list with ingredients (Recipe Details Screen) 
   
