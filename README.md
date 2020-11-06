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

#### Recipe

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | id            | Int   | spoonacular id for the recipe |
   | title         | String| title of the recipe |
   | image      | String | image name |
   | imageType     | String | type of image |
   | likes  | Integer | number of likes for this recipe
   | missedIngredientCount | Integer | number of missed ingredients
   | missedIngredients | Array | Array of ingredient objects missed
   | unusedIngredients | Array | Arrays of unused ingredient objects
   | usedIngredientCount | Integer | count of used ingredients
   | usedIngredients | Array | Array of used ingredients objects
   
   
 #### Recipe Information

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | id            | Int   | spoonacular id for the recipe |
   | title | String | title of the recipe
   | dairyFree |  Bool | whether this recipe is dairy free or not
   | diets | Array | Array of strings describing diets that this recipe falls under
   |  dishTypes | Array | Array of strings listing dish types
   |  extendedIngredients | Array | Array of ExtendedIngredients
   |  gaps | String | String stating whether recipe information has gaps
   | glutenFree | Bool | whether this recipe is gluten free or not
   | healthScore | Double | double rating how healthy this recipe is
   | image | String | string of image url for this recipe
   | imageType | String | format of the image
   | instructions | String | string containing the instructions for this recipe
   | ketogenic | Bool | whether this recipe is ketogenic or not
   | license | String | liscense of this recipe
   | lowFodmap | Bool | whether recipe is low fodmap
   | pricePerServing | Double | price per serving of this recipe
   | readyInMinutes | Int | total minutes to finish recipe
   | servings | Int | number of servings this recipe makes
   | sourceName | String | source name of this recipe
   | sourceUrl | String | source url of this recipe
   | spoonacularScore | Double | rating for this recipe on spoonacular
   | spoonacularSourceUrl | String | source url of this recipe
   | summary | String | short description of recipe
   | sustainable | Bool | whether this recipe is sustainable or not
   | vegan | Bool | whether recipe is vegan or not
   | vegetarian | Bool | whether recipe is vegetarian or not
   | veryHealthy | Bool | whether this recipe is healthy or not
   | veryPopular | Bool | whether this recipe is popular or not
   | weightWatcherSmartPoints | Integer | amount of weight watcher points for this recipe
   | whole30 | Bool | whether the recipe is whole30 approved
   | winePairing | WinePairing | winepairing object for this recipe
   
 #### AnalyzedInstruction 

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | steps            | Array   | array of steps |
 
  #### Step 

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | number            | Integer   | number of step |
   | step            | String   | step instruction |

   
 #### Ingredient 

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | id            | Integer   | spoonacular id for the ingredient |
   | name         | String| name of ingredient |
   | original      | String | original count and ingredient text from recipe |
   | originalName     | String | original text for ingredient name |
   | unit | String  | unit of measurement for this ingredient
   | unitLong | String | full unit of measurement for this ingredient
   | unitShort | String | abbreviated unit of measurement for this ingredient
   
    
 #### ExtendedIngredient 

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | id            | Integer   | id for this ingredient |
   | name            | String   | name of this ingredient |
   | aisle            | String   | category of aisles where this ingredient can be found |
   | amount            | Double   | amount of ingredient needed for recipe |
   | consitency            | String   | consistency of ingredient |
   | image            | String   | image url for this ingredient |
   | measures         | Measure   | measure struct with metric information |
   | meta         | Array   | array of strings of meta information |
   | original | String | original text for this ingredient in recipe
   | originalName | String | name of the ingredient
   | unit | String | unit of measurement for this ingredient

#### Measure 

 | Property      | Type     | Description |
 | ------------- | -------- | ------------|
 | metric            | Metric   | struct containing metric units |
 | us            | Me   | struct containing us measure units |
 
#### Metric

 | Property      | Type     | Description |
 | ------------- | -------- | ------------|
 | amount      | Double   | amount for this metric measurement |
 | unitLong    | String   | unit name for metric measurement |
 | unitShort   | String   | abrreviated name for metric measurement |

 
#### Me 

 | Property      | Type     | Description |
 | ------------- | -------- | ------------|
 | amount      | Double   | amount for this us measurement |
 | unitLong    | String   | unit name for us measurement |
 | unitShort   | String   | abrreviated name for us measurement |  
 
 
 #### WinePairing 

 | Property      | Type     | Description |
 | ------------- | -------- | ------------|
 | pairedWines      | Array   | array of strings of wine names|
 | pairingText    | String   | string describing how these wines pair with this recipe|
 | productMatches   | Array   |  array of pairec wines and information |  
 
 #### ProductMatch 

 | Property      | Type     | Description |
 | ------------- | -------- | ------------|
 | id      | Integer   | id for this product match |
 | title   | String   | name for product |  
 | averageRating    | Double   | average rating for this product|
 | descriptionField   | String   | short description of this product |  
 | imageUrl      | String   | image url of this product |
 | link      | String   | link of where o buy this product |
 | price    | String   | product price |
 | score   | Float   | score for product |  

   
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
    
#### Parse API
- Base URL - https://parseapi.back4app.com

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `POST`   | https://parseapi.back4app.com/users  | POST request to Parse API to sign up a new user for the app (Login Screen)
    `GET`   |  https://parseapi.back4app.com/login | GET request to Parse API to log in into a user account (Login Screen)
    `POST`  | https://parseapi.back4app.com/classes/MyCustomClassName | POST request to Parse API to to create a new object (Recipe Details Screen)
    `GET`  | https://parseapi.back4app.com/classes/MyCustomClassName | GET request to Parse API to to retrieve an object (Faovrites and Shopping List Screen)
