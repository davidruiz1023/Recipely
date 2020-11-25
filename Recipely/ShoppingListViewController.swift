//
//  ShoppingListViewController.swift
//  Recipely
//
//  Created by David Ruiz on 10/30/20.
//

import UIKit
import Parse

class ShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var shoppingListTableView: UITableView!
    
    var shoppingList = [[String:Any]]()
    let refreshControl = UIRefreshControl()
    var noDataLabel: UILabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        shoppingListTableView.dataSource = self
        shoppingListTableView.delegate = self
        shoppingListTableView.estimatedRowHeight = 44
        refreshControl.addTarget(self, action: #selector(loadShoppingList), for: .valueChanged)
        //Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(loadShoppingList), userInfo: nil, repeats: true)
        self.shoppingListTableView.refreshControl = refreshControl
        self.shoppingListTableView.tableFooterView = UIView()
        //shoppingListTableView.rowHeight = UITableView.automaticDimension
        loadShoppingList()
    }
    
    @objc func loadShoppingList() {
        
        let user = PFUser.current()
        
        //var shoppingList = user?["shoppingList"]
        shoppingList.removeAll()
        if user?["shoppingList"] != nil {
            var items = (user?["shoppingList"]) as!  [[String:Any]]
            
            
            for item in items {
                print("From db: ")
                print(item["name"])
                if !shoppingList.contains(where: {$0["name"] as! String == item["name"] as! String}) {
                    shoppingList.append(item)
                }
            }
            
            for i in shoppingList {
                print("From db: ")
                print(i["name"])
                //shoppingList?.append(item)
            }
        }
        // update table
        self.shoppingListTableView.reloadData()
        
        // stop animating once new data loaded
        self.refreshControl.endRefreshing()
        
    }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        if shoppingList.count > 0 {
           count = shoppingList.count
           noDataLabel.isHidden = true
           tableView.backgroundView = nil
            tableView.separatorStyle  = .singleLine

        }
        else if shoppingList.count == 0 {
           
            noDataLabel.text          = "Your shopping list is empty!"
            noDataLabel.textColor     = UIColor.gray
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            count = 0
        }
      
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell") as! ShoppingItemTableViewCell
        
        let ingredient = shoppingList[indexPath.row]
        let size = 100
        let basepath = "https://spoonacular.com/cdn/ingredients_\(size)" + "x" + "\(size)/"
        let ingredientImage = ingredient["image"] ?? nil
        if ingredientImage != nil {
           // let imageName = String(describing: ingredientImage)
            let imageUrl = URL(string: basepath + (ingredientImage as! String))
            let data = try? Data(contentsOf: imageUrl!)
                
            if let imageData = data {
                cell.ingredientImageView.image = UIImage(data: imageData)
            }
        }
        //cell.ingredientImageView.af.setImage(withURL: URL(string: ingredient["image"]! as! String)!)
        
        cell.ingredeintNameLabel.text = ingredient["name"] as? String
        
        var amount:Double = ingredient["amount"] as? Double ?? 0.00
        
        // format the amount
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        cell.amountLabel.text = formatter.string(from: amount as NSNumber)
        cell.unitsLabel.text = ingredient["unit"] as? String ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            shoppingListTableView.deleteRows(at: [indexPath], with: .left)
            
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
