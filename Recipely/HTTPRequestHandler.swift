//
//  HTTPRequestHandler.swift
//  Recipely
//
//  Created by David Ruiz on 10/22/20.
//

import Foundation

struct APICALLS {
    static let APIKey = "34b808261c6f4cf1b9e4c2e786bd49a5" // Your API KEY
}

// Recipe object
struct Recipe: Codable {
    let id : Int?
    let image : String?
    let imageType : String?
    let likes : Int?
    let missedIngredientCount : Int?
    let missedIngredients : [Ingredient]?
    let title : String?
    let unusedIngredients : [Ingredient]?
    let usedIngredientCount : Int?
    let usedIngredients : [Ingredient]?
}

// Ingredient Object
struct Ingredient: Codable {
    let aisle : String?
    let amount : Double?
    let id : Int?
    let image : String?
    let meta : [String]?
    let metaInformation : [String]?
    let name : String?
    let original : String?
    let originalName : String?
    let originalString : String?
    let unit : String?
    let unitLong : String?
    let unitShort : String?
}

struct RecipeInformation: Codable {
    let aggregateLikes : Int?
   // let analyzedInstructions : [AnalyzedInstruction]?
    let cheap : Bool?
    let creditsText : String?
   // let cuisines : [String]?
    let dairyFree : Bool?
    let diets : [String]?
    let dishTypes : [String]?
    let extendedIngredients : [ExtendedIngredient]?
    let gaps : String?
    let glutenFree : Bool?
    let healthScore : Double?
    let id : Int?
    let image : String?
    let imageType : String?
    let instructions : String?
    let ketogenic : Bool?
    let license : String?
    let lowFodmap : Bool?
    //let occasions : [String]?
    let pricePerServing : Double?
    let readyInMinutes : Int?
    let servings : Int?
    let sourceName : String?
    let sourceUrl : String?
    let spoonacularScore : Double?
    let spoonacularSourceUrl : String?
    let summary : String?
    let sustainable : Bool?
    let title : String?
    let vegan : Bool?
    let vegetarian : Bool?
    let veryHealthy : Bool?
    let veryPopular : Bool?
    let weightWatcherSmartPoints : Int?
    let whole30 : Bool?
    let winePairing : WinePairing?
}

struct AnalyzedInstruction:Codable {
    let steps: [String]
}

struct Step:Codable {
    let number:Int?
    let step:String?
}

struct WinePairing: Codable {
    let pairedWines : [String]?
    let pairingText : String?
    let productMatches : [String]?
}

struct ProductMatch : Codable {
    let averageRating : Double?
    let descriptionField : String?
    let id : Int?
    let imageUrl : String?
    let link : String?
    let price : String?
    let ratingCount : Int?
    let score : Float?
    let title : String?
}

struct ExtendedIngredient : Codable {
    let aisle : String?
    let amount : Double?
    let consitency : String?
    let id : Int?
    let image : String?
    let measures : Measure?
    let meta : [String]?
    let name : String?
    let original : String?
    let originalName : String?
    let unit : String?
}
struct Measure : Codable {
    let metric : Metric?
    let us : Me?
}

struct Me : Codable {
    let amount : Double?
    let unitLong : String?
    let unitShort : String?
}

struct Metric : Codable {
    let amount : Double?
    let unitLong : String?
    let unitShort : String?
}

// API Request Handler
class HTTPRequestHandler {
    //  Function to execute GET request and pass data from escaping closure
    private func executeGetRequest(with urlString: String, completion: @escaping (Data?) -> ()) {

        let request = URLRequest(url: URL(string: urlString)!)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            //  Log errors (if any)
            if error != nil {
                print(error.debugDescription)
                
            } else {
                //  Passing the data from closure to the calling method
                //print("JSON String: \(String(describing: String(data: data!, encoding: .utf8)))") // Print RAW JSON string from downloaded data
                let response = response as! HTTPURLResponse
                print("Status Code: \(response.statusCode)")
                completion(data)
            }
        }.resume()  // Starting the dataTask
    }
    
    //  Function to search for recipes using keywords - Calls executeGetRequest(with urlString:) and receives data from the closure.
    func searchByIngredients(searchString: String, completion: @escaping ([Recipe]) -> ()) {
        let whitespaceRemoved = searchString.replacingOccurrences(of: " ", with: "") // remove whitespace from search string
        let finalFormattedString = whitespaceRemoved.replacingOccurrences(of: ",", with: ",+") // Formats search string if commas are present
        let numberOfResults = "10" // Number of results to return
        
        let urlString = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(finalFormattedString)&number=\(numberOfResults)&apiKey=\(APICALLS.APIKey)"
        
        //  Calling executeGetRequest(with:)
        executeGetRequest(with: urlString) { (data) in  // Data received from closure
                //  JSON parsing
                let decoder = JSONDecoder()
                guard let results = try? decoder.decode([Recipe].self, from: data!) else {
                    print("no results")
                    return
                }
                
                let recipeList: [Recipe] = results
            
                //  Passing parsed JSON data from closure to the calling method.
                completion(recipeList)
        }
    }
    
    //  Function to get a specific recipe information - Calls executeGetRequest(with urlString:) and receives data from the closure.
    func getRecipeInformation(recipeID: String, completion: @escaping (RecipeInformation) -> ()) {
        
        let urlString = "https://api.spoonacular.com/recipes/\(recipeID)/information?includeNutrition=true&apiKey=\(APICALLS.APIKey)"
        
        //  Calling executeGetRequest(with:)
        executeGetRequest(with: urlString) { (data) in  // Data received from closure
                //  JSON parsing
                let decoder = JSONDecoder()
                guard let results = try? decoder.decode(RecipeInformation.self, from: data!) else {
                    print("no results")
                    return
                }
                
                let recipeInfo: RecipeInformation = results
            
                //  Passing parsed JSON data from closure to the calling method.
                completion(recipeInfo)
        }
    }
    
       
    
    //  Function to get a random recipe information - Calls executeGetRequest(with urlString:) and receives data from the closure.
    func getRandomRecipe(completion: @escaping (RecipeInformation) -> ()) {
        
        let numberOfResults = "1" // Number of results to return
        
        let urlString = "https://api.spoonacular.com/recipes/random?number=\(numberOfResults)&apiKey=\(APICALLS.APIKey)"
        
        //  Calling executeGetRequest(with:)
        executeGetRequest(with: urlString) { (data) in  // Data received from closure
                //  JSON parsing
                let decoder = JSONDecoder()
                guard let results = try? decoder.decode(RecipeInformation.self, from: data!) else {
                    print("no results")
                    return 
                }
                
                let recipeInfo: RecipeInformation = results
            
                //  Passing parsed JSON data from closure to the calling method.
                completion(recipeInfo)
        }
    }
    
}
