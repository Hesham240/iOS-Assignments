//
//  CategoryTabelViewControllerTableViewController.swift
//  Checklists
//
//  Created by Hesham Mohamad on 4/27/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController,CategoryDetailViewControllerDelegate, chechlistMydelegation
{
  

  var Categories: [CustomCategoryList]
  
  
  var selectedCategoryList:CustomCategoryList!
  var idx:Int! // hold the index of the selected Category list in the array
  
  required init?(coder aDecoder: NSCoder)
  {
    Categories = [CustomCategoryList]()
    super.init(coder: aDecoder)
    loadCustomCategoryList()
  }

    override func viewDidLoad()
    {
        super.viewDidLoad()
      
    }
  
  func imageTapped(tapGestureRecognizer : UITapGestureRecognizer)
  {
    //let tappedImage = tapGestureRecognizer.view as! UIImageView
    //tappedImage.backgroundColor = UIColor.
    
    print("Image Selected")
  }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return Categories.count
  }
  



  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "myCategory", for: indexPath)
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    let item = Categories[indexPath.row]
    configureImage(for: cell,with: item)
    configureText(for: cell, with: item)
    configureDetails(for: cell,with: item)
    let f = cell.viewWithTag(500) as! UIImageView
    f.isUserInteractionEnabled = true
    f.addGestureRecognizer(tapGestureRecognizer)
    //configureCheckmark(for: cell, with: item)
    return cell
  }
  
  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath)
  {
    
    if let cell = tableView.cellForRow(at: indexPath)
    {
      let item = Categories[indexPath.row]
     
      selectedCategoryList = item
      idx = indexPath.row
      
    }
    
    

    tableView.deselectRow(at: indexPath, animated: true)
    saveCategorylistItems()
  }
  
  
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCellEditingStyle,
                          forRowAt indexPath: IndexPath)
  {
    Categories.remove(at: indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
    saveCategorylistItems()
  }
  
  func configureText(for cell: UITableViewCell,
                     with item: CustomCategoryList)
  {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.listName
  }
  
  func configureImage(for cell: UITableViewCell,
                     with item: CustomCategoryList)
  {
    let catImage = cell.viewWithTag(500) as! UIImageView
    catImage.image = UIImage(named:item.iconName)
  }
  
  func configureDetails(for cell: UITableViewCell,
                      with item: CustomCategoryList)
  {
    let numberOfCategoryItems = cell.viewWithTag(250) as! UILabel
    numberOfCategoryItems.text = String(item.numberOfItemsInList)
  }
  
  
  func chechlistFileAfterEditing(_ controller: ChecklistViewController,
                                 didFinishEditing item: URL, numberOFItems: Int)
  {
    
//    selectedCategoryList.pathToitems = item
//    Categories[idx] = selectedCategoryList
    
    if let cell = self.tableView.cellForRow(at: IndexPath(row: idx!, section: 0))
    {
      let item = Categories[idx!]
      item.numberOfItemsInList = numberOFItems
      configureDetails(for: cell,with: item )
    }
    
    
    
    
  }
  
  func categoryDetailViewControllerDidCancel(_ controller: CategoryDetailViewController)
  {
    dismiss(animated: true, completion: nil)
  }
  
  func categoryDetailViewController(_ controller: CategoryDetailViewController,
                                didFinishAdding item: CustomCategoryList)
  {
    let newRowIndex = Categories.count
    Categories.append(item)
  let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)

    
    if let cell = tableView.cellForRow(at: indexPath)
    {
      configureText(for: cell, with: item)
      configureImage(for: cell, with: item)
    }
    
    
    
    
    
    dismiss(animated: true, completion: nil)
    saveCategorylistItems()
  }
  
  func categoryDetailViewController(_ controller: CategoryDetailViewController,
                                didFinishEditing item: CustomCategoryList)
  {
    if let index = Categories.index(of: item) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureText(for: cell, with: item)
        configureImage(for: cell, with: item)
      }
    }
    dismiss(animated: true, completion: nil)
    saveCategorylistItems()
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "AddCategory"
    {
      let navigationController = segue.destination as! UINavigationController
      let controller = navigationController.topViewController as! CategoryDetailViewController
      controller.delegate = self
      
    }
    else if segue.identifier == "EditCategory"
    {
      let navigationController = segue.destination as! UINavigationController
      let controller = navigationController.topViewController as! CategoryDetailViewController
      controller.delegate = self
      
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
      {
        controller.categoryToEdit = Categories[indexPath.row]
      }
    }
    else if segue.identifier == "viewItems"
    {
      let navigationController = segue.destination as! UINavigationController
      let controller = navigationController.topViewController as! ChecklistViewController
      
      
      let cell = sender as! UITableViewCell
      let indx = self.tableView.indexPath(for: cell)
      
      let item = Categories[(indx?.row)!]
      controller.pathOfItems = item.pathToitems //item.pathToitems
      controller.delegate = self
    }
  }

  func documentsDirectory() -> URL
  {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  func dataFilePath() -> URL
  {
    return documentsDirectory().appendingPathComponent("CategoryList.plist")
  }
  
  func loadCustomCategoryList()
  {
    let path = dataFilePath()
    if let data = try? Data(contentsOf: path) {
      let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
      Categories = unarchiver.decodeObject(forKey: "CustomCategoryList") as! [CustomCategoryList]
      unarchiver.finishDecoding()
    }
  }
  
  func saveCategorylistItems()
  {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWith: data)
    archiver.encode(Categories, forKey: "CustomCategoryList")
    archiver.finishEncoding()
    data.write(to: dataFilePath(), atomically: true)
  }

  
  
  
  
  

}
