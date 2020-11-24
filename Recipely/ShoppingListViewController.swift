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
    
    var shoppingList:[[String:Any]] = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        shoppingListTableView.dataSource = self
        shoppingListTableView.delegate = self
        shoppingListTableView.estimatedRowHeight = 44
        refreshControl.addTarget(self, action: #selector(loadShoppingList), for: .valueChanged)
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(loadShoppingList), userInfo: nil, repeats: true)
        self.shoppingListTableView.refreshControl = refreshControl
        //shoppingListTableView.rowHeight = UITableView.automaticDimension
        
        loadShoppingList()
    }
    
    @objc func loadShoppingList() {
        
        let user = PFUser.current()
        
        //var shoppingList = user?["shoppingList"]
        var items = (user?["shoppingList"]) as! Array<Dictionary<String, Any>>
        
        shoppingList.removeAll()
        for item in items {
            print("From db: ")
            print(item["name"])
            //if !shoppingList.contains(where: {$0["name"] as! String == item["name"] as! String}) {
                shoppingList.append(item)
            //}
        }
        
        for i in shoppingList {
            print("From db: ")
            print(i["name"])
            //shoppingList?.append(item)
        }
        // update table
        self.shoppingListTableView.reloadData()
        // stop animating once new data loaded
        self.refreshControl.endRefreshing()
        
    }
    
    // Implement the delay method
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell") as! ShoppingItemTableViewCell
        
        let ingredient = shoppingList[indexPath.row]
        let size = 100
        let basepath = "https://spoonacular.com/cdn/ingredients_\(size)/"
        let ingredientImage = ingredient["image"] ?? nil
        if ingredientImage != nil {
            let imageName = String(describing: ingredientImage)
            let imageUrl = URL(string: basepath + imageName)
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
        
        return cell
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
