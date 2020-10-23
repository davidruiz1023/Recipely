//
//  ViewController.swift
//  Recipely
//
//  Created by David Ruiz on 10/20/20.
//

import UIKit
import AlamofireImage

class SearchRecipeViewController: UIViewController {
    
    let httpHandler = HTTPRequestHandler() // httpHandler object for network requests
    var recipeList: [Recipe] = [] // List of recipes. Will append recipes once results are downloaded
    @IBOutlet weak var recipeTableview: UITableView!
    @IBOutlet weak var searchBarTextField: UITextField! // searchbar textfield
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    // Function called when search button is pressed
    @IBAction func searchButtonPressed(_ sender: Any) {
        // If searchbar is not empty, perform network request using keywords in searchbar
        if !searchBarTextField.text!.isEmpty {
            httpHandler.searchByIngredients(searchString: searchBarTextField.text!) { (recipeList: [Recipe]) in
                for recipe in recipeList {
                    print(recipe)
                }
                
                // assign the downloaded list of recipes to recipeList
                self.recipeList = recipeList
                
                // reload table view on main thread
                DispatchQueue.main.async {
                    self.recipeTableview.reloadData()
                }
            }
        } else {
            // show alert that search bar is empty
        }
    }
    
}

extension SearchRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        let recipeCell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipeTableViewCell
        
        let recipe = recipeList[indexPath.row]
        recipeCell.recipeImage.af.setImage(withURL: URL(string: recipe.image!)!)
        recipeCell.recipeTitle.text = recipe.title
        recipeCell.recipeLikeCount.text = "Likes: \(recipe.likes!.description)"
        
        cell = recipeCell
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = recipeList[indexPath.row]
        httpHandler.getRecipeInformation(recipeID: selectedRecipe.id!.description) { (recipeInfo: RecipeInformation) in
            print(recipeInfo)
        }
    }
    
    
}

