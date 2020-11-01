# Recipely
CST495 Final App Project

Group: Recipely
Group Members				Student Number               	Contact

David Ruiz				004015588		            daruiz@csumb.edu
Kevin Guzman			004219623			keguzman@csumb.edu
Mariana Duarte			003067297			mduarte@csumb.edu
Mireya Leon				002954041			mleon@csumb.edu

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
[Description of your app]

### App Evaluation
[Evaluation of your app across the following attributes]
- Category: Food & Drink
- Mobile: This app would be primarily developed for mobile
- Story: The user can explore recipes, favorite recipes, and create shopping lists based on recipes.
- Market: Any individual could choose 
- Habit: This app could be used as often or on occasion for culinary inspiration.

- **Scope:**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* 1. User can SignIn / LogOut
* 2. User can search recipes by ingredients
* 3. User can see their history of searched recipes
* 4. User can click recipe and see info about it
* 5. User can add ingredients to a shopping list from a recipe. Items can be checked off (swipe to delete)
* ...

**Optional Nice-to-have Stories**

* [fill in your required user stories here]
* ...

### 2. Screen Archetypes

* [list first screen here]
   * [list associated required story here]
   * ...
* [list second screen here]
   * [list associated required story here]
   * ...

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [fill out your first tab]
* [fill out your second tab]
* [fill out your third tab]

**Flow Navigation** (Screen to Screen)

* [list first screen here]
   * [list screen navigation here]
   * ...
* [list second screen here]
   * [list screen navigation here]
   * ...

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups
https://miro.com/app/board/o9J_kh1a5c4=/

### [BONUS] Interactive Prototype
https://marvelapp.com/prototype/5ff7j92/screen/73854579

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

- Network request to parse when logging in. (Login Screen)
- GET request to Spoonacular API to search for recipes by ingredients (Search Screen) https://api.spoonacular.com/recipes/findByIngredients 
- GET request to Spoonacular API to get recipe details (Recipe Details Screen) https://api.spoonacular.com/recipes/{id}/information
- POST request to Spoonacular API to create a shopping list with ingredients (Recipe Details Screen) https://api.spoonacular.com/mealplanner/{username}/shopping-list/items
