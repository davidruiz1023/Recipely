//
//  ViewController.swift
//  Recipely
//
//  Created by David Ruiz on 10/20/20.
//

import UIKit
import AlamofireImage
import Parse

class SearchRecipeViewController: UIViewController {
    
    let httpHandler = HTTPRequestHandler() // httpHandler object for network requests
    var recipeList: [Recipe] = [] // List of recipes. Will append recipes once results are downloaded
    var recipeInfoList: RecipeInformation! // store the selected recipe
    @IBOutlet weak var recipeTableview: UITableView!
    @IBOutlet weak var searchBarTextField: UITextField! // searchbar textfield
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
            
        delegate.window?.rootViewController = loginViewController
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    // Function called when search button is pressed
    @IBAction func searchButtonPressed(_ sender: Any) {
        // If searchbar is not empty, perform network request using keywords in searchbar
        if !searchBarTextField.text!.isEmpty {
            httpHandler.searchByIngredients(searchString: searchBarTextField.text!) { (recipeList: [Recipe]) in
                if !recipeList.isEmpty {
                    // print all recipes in recipeList to console window
                    for recipe in recipeList {
                        print(recipe)
                    }
                    
                    // assign the downloaded list of recipes to recipeList
                    self.recipeList = recipeList
                    
                    // reload table view on main thread
                    DispatchQueue.main.async {
                        self.recipeTableview.reloadData()
                    }
                } else {
                    // show alert that no results were found. Display on mainthread
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "No Results", message: NSLocalizedString("No Recipes found with searched ingredient(s). Try searching with different ingredients", comment: ""), preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .default))
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        } else {
                // show alert that search bar is empty
                let alertController = UIAlertController(title: "Empty Search", message: NSLocalizedString("Search bar is empty. Enter ingredients into search bar. Separate with comma if more than one is searched", comment: ""), preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .default))
                present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        
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
       /* let selectedRecipe = recipeList[indexPath.row]
        httpHandler.getRecipeInformation(recipeID: selectedRecipe.id!.description) { (recipeInfo: RecipeInformation) in
            print(recipeInfo)
            self.recipeInfoList = recipeInfo/
        
        }*/
    }
    
    
    // send recipe information to Recipe Detail View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetailsSegue" {
            let cell = sender as! UITableViewCell
            if let indexPath = recipeTableview.indexPath(for: cell) {
                let selectedRecipe = recipeList[indexPath.row]
                let detailViewController = segue.destination as! RecipeDetailViewController
                detailViewController.currentRecipe = selectedRecipe
            }
        }
            
            
    }
    
    
    
    
}

