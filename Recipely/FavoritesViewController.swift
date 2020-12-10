//
//  FavoritesViewController.swift
//  Recipely
//
//  Created by David Ruiz on 10/30/20.
//

import UIKit
import Parse
import AlamofireImage

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var recipeList: [Recipe] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getFavorites()
        self.tableView.reloadData()
    }
    
    func getFavorites() {
        self.recipeList = []
        let user = PFUser.current()!
        
        let query = PFQuery(className: "Favorites")
        query.whereKey("user", equalTo: user.objectId!)
        
        query.findObjectsInBackground { (objs, error) in
            if objs != nil {
                print(objs!.count)
                for obj in objs! {
                    let jsonString = obj["data"] as! String
                    let jsonData = Data(jsonString.utf8)
                    print(jsonData)
                    
                    let decoder = JSONDecoder()

                    do {
                        let recipe = try decoder.decode(Recipe.self, from: jsonData)
                        print(recipe)
                        self.recipeList.append(recipe)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
                self.tableView.reloadData()
                print("Recipes Found")
                print(self.recipeList.count)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare function Triggered!")
        if segue.identifier == "recipeDetailsFav" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let selectedRecipe = recipeList[indexPath.row]
                let detailViewController = segue.destination as! RecipeDetailViewController
                detailViewController.currentRecipe = selectedRecipe
            }
        }
            
            
    }

}
