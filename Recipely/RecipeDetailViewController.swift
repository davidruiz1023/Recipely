//
//  RecipeDetailViewController.swift
//  Recipely
//
//  Created by Mireya Leon on 10/23/20.
//

import UIKit
import Parse

class RecipeDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    

   
    
    @IBOutlet weak var instructionsTableview: UITableView!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionHeadLabel: UILabel!

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var addToShopListButton: UIBarButtonItem!
    
    let httpHandler = HTTPRequestHandler() // httpHandler object for network requests
    
    var currentRecipe: Recipe!
    var recipeInfo: RecipeInformation!
    var extendedIngredients : [ExtendedIngredient]?
    var ingredients:[Ingredient]?
    var stepsBreakDown = [String]()
    
    var favorited:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        
        instructionsTableview.dataSource = self
        instructionsTableview.delegate = self
        if (self.recipeInfo == nil) {
            self.instructionHeadLabel.text = "No instructions available at this moment."
        }
        setOutlets()
       
       
    }
    
  
    @IBAction func setFavorite(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            self.setFavoritedImage(true)
                  
        } else {
            self.setFavoritedImage(false)
        }
    }
    
    func setFavoritedImage(_ isFavorited: Bool) {
        favorited = isFavorited
        if (favorited) {
            favoriteButton.setImage(UIImage(named: "heart-red" ), for:  UIControl.State.normal)
        } else {
            favoriteButton.setImage(UIImage(named: "heart-outline" ), for:  UIControl.State.normal)
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    
    @IBAction func addIngredients(_ sender: Any) {
        print("cliecked shopp")
        let user = PFUser.current()
        do {
            var newIngredients:[[String:Any]] = []
            if extendedIngredients != nil {
                for item in extendedIngredients! {
                    var encoded = try JSONEncoder().encode(item)
                    //print(String(bytes: encoded, encoding: .utf8))
                    var dict = convertToDictionary(text: String(bytes: encoded, encoding: .utf8) ?? "")
                    //print(dict)
                    newIngredients.append(dict!)
                }
            }
            var items = [[String:Any]]()
            var updatedItems = [[String:Any]]()
            if user?["shoppingList"]  != nil {
                items = (user?["shoppingList"]) as! [[String:Any]]
            }
            //var shoppingList = user?["shoppingList"] ?? []
            
            
           
        
            //var items = (user?["shoppingList"]) as! [[String:Any]]
           
            if items.isEmpty {
                for i in newIngredients {
                    updatedItems.append(i)
                }
            } else {
                for i in newIngredients {
                    if items.contains(where: {$0["name"] as! String == i["name"] as! String}) {
                        for var item in items {
                            if item["name"] as! String == i["name"] as! String {
                                //print("dup")
                                var val = (item["amount"] as! Double) + (i["amount"] as! Double)
                                item["amount"]! = val
                                //print(val)
                                //var temp = item
                                updatedItems.append(item)
                            }
                        }
                    }
                   
                    else {
                        updatedItems.append(i)
                    }
                    
                }
                
                for currItem in items {
                    if !updatedItems.contains(where: {$0["name"] as! String == currItem["name"] as! String}) {
                        updatedItems.append(currItem)
                    }
                }
            }
            user?["shoppingList"] = updatedItems
            
           
           
            user?.saveInBackground {
              (success: Bool, error: Error?) in
              if (success) {
                print("added items to list")
              } else {
                print(error?.localizedDescription as Any)
              }
            }
        } catch {
            print(error)
        }
       
       
        
       
        
    }
    
    func setOutlets() {
       
        httpHandler.getRecipeInformation(recipeID: currentRecipe.id!.description) { (recipeInfo: RecipeInformation) in
            DispatchQueue.main.async {
                self.recipeNameLabel.text = self.currentRecipe.title
                self.recipeInfo = recipeInfo
                self.cookTimeLabel.text = String(recipeInfo.readyInMinutes ?? 0) + " min"
                self.servingsLabel.text = String(recipeInfo.servings ?? 0) + " servings"
                self.scoreLabel.text = (recipeInfo.healthScore?.description ?? "--" ) + " health score"
                if recipeInfo.extendedIngredients != nil {
                    self.extendedIngredients = recipeInfo.extendedIngredients
                }
                let steps = recipeInfo.instructions
               
                if steps != nil {
                    //print(steps!)
                    self.instructionHeadLabel.text = "Instructions"

                    var formatSteps: String = steps!
                    if steps?.prefix(12) == "Instructions" {
                        formatSteps = formatSteps.replacingOccurrences(of: "Instructions", with: "")
                    }
                
               
                    var line = ""
                    for c in formatSteps {
                        line.append(c)
                        if c == "." {
                            let range = NSRange(location: 0, length: line.utf16.count)
                            let regex = try! NSRegularExpression(pattern: "[^0-9]\\s{2,}")
                            if regex.firstMatch(in: line, options: [], range: range) != nil {
                                if line[line.startIndex].isNumber {
                                    line = regex.stringByReplacingMatches(in: line, options:[], range: range, withTemplate: String(line[line.startIndex]) + ".  ")
                                }
                            }
                            self.stepsBreakDown.append(line.trimmingCharacters(in: .whitespaces))
                            line = ""
                        }
                    }
                    print("steps")
                    for s in self.stepsBreakDown {
                        print(s)
                    }
                
                }
                
                let recipeImage = recipeInfo.image
                if recipeImage != nil {
                    let imageUrl = URL(string: String(recipeImage!))
                    let data = try? Data(contentsOf: imageUrl!)
                        
                    if let imageData = data {
                        self.recipeImageView.image = UIImage(data: imageData)
                    }
                }
                let tintView = UIView()
                tintView.backgroundColor = UIColor(white: 0, alpha: 0.2)
                tintView.frame = CGRect(x: 0, y: 0, width: self.recipeImageView.frame.width * 2, height: self.recipeImageView.frame.height * 2 )
                self.recipeImageView.addSubview(tintView)
                self.instructionsTableview.reloadData()
                self.ingredientsTableView.reloadData()
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
    

 }    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             
        var count: Int?
        
        if tableView == self.ingredientsTableView {
            count = extendedIngredients?.count
        }
        
        if stepsBreakDown.count > 0 && tableView == self.instructionsTableview {
            count =  stepsBreakDown.count
        }
               
        return count ?? 0
    }
           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               
            var cell: UITableViewCell?
            
                if tableView == self.ingredientsTableView {
                    cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell" ,for: indexPath) as! IngredientTableViewCell
                    let ingredient = extendedIngredients?[indexPath.row]
                    let amount = ingredient?.measures?.us?.amount
                    let formatter = NumberFormatter()
                    formatter.minimumFractionDigits = 0
                    formatter.maximumFractionDigits = 2
                      
                    (cell as! IngredientTableViewCell).amountLabel.text = formatter.string(from: amount! as NSNumber)
                    (cell as! IngredientTableViewCell).metricLabel.text = ingredient?.measures?.us?.unitShort ?? ""
                    (cell as! IngredientTableViewCell).ingredientNameLabel.text = ingredient?.name
                       //return cell
                }
                
                if tableView == self.instructionsTableview {
                    cell = tableView.dequeueReusableCell(withIdentifier: "instructionCell" ,for: indexPath) as! InstructionTableViewCell
                    let instruction = stepsBreakDown[indexPath.row]
                    (cell as! InstructionTableViewCell).instructionsLabel.text = instruction
                    //return cell
                }
               return cell!
           }
    
   
}
