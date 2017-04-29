//
//  ViewController.swift
//  Checklists
//
//  Created by Matthijs on 04/07/2016.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit
protocol chechlistMydelegation : class
{
  func chechlistFileAfterEditing(_ controller: ChecklistViewController,
                                 didFinishEditing item: URL, numberOFItems: Int)
}

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate
{
  var items: [ChecklistItem]
  
  var pathOfItems : URL?
  
   weak var delegate: chechlistMydelegation?
  
  required init?(coder aDecoder: NSCoder)
  {
    items = [ChecklistItem]()
    super.init(coder: aDecoder)
    //loadChecklistItems()
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    loadChecklistItems()
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int
  {
    return items.count
  }
  
  
    @IBAction func Done(_ sender: Any)
    {
      
      saveChecklistItems()
      delegate?.chechlistFileAfterEditing(self, didFinishEditing: pathOfItems!,numberOFItems: items.count)
        self.dismiss(animated: true, completion: nil)
    }
  
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "ChecklistItem", for: indexPath)
    
    let item = items[indexPath.row]
    
    configureText(for: cell, with: item)
    configureCheckmark(for: cell, with: item)
    return cell
  }

  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath)
  {
    
    if let cell = tableView.cellForRow(at: indexPath)
    {
      let item = items[indexPath.row]
      item.toggleChecked()
      configureCheckmark(for: cell, with: item)
    }
    tableView.deselectRow(at: indexPath, animated: true)
    saveChecklistItems()
  }

  func configureCheckmark(for cell: UITableViewCell,
                          with item: ChecklistItem)
  {
    let label = cell.viewWithTag(1001) as! UILabel
    
    if item.checked {
      label.text = "√"
    } else {
      label.text = ""
    }
  }
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCellEditingStyle,
                          forRowAt indexPath: IndexPath)
  {
    items.remove(at: indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
    saveChecklistItems()
  }

  func configureText(for cell: UITableViewCell,
                     with item: ChecklistItem)
  {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  }
  
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
  {
    dismiss(animated: true, completion: nil)
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController,
                             didFinishAdding item: ChecklistItem)
  {
    let newRowIndex = items.count
    items.append(item)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    
    dismiss(animated: true, completion: nil)
    saveChecklistItems()
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController,
                             didFinishEditing item: ChecklistItem)
  {
    if let index = items.index(of: item)
    {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath)
      {
        configureText(for: cell, with: item)
      }
      saveChecklistItems()
    }
    dismiss(animated: true, completion: nil)
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "AddItem"
    {
      let navigationController = segue.destination as! UINavigationController
      let controller = navigationController.topViewController as! ItemDetailViewController
      controller.delegate = self

    }
    else if segue.identifier == "EditItem"
    {
      let navigationController = segue.destination as! UINavigationController
      let controller = navigationController.topViewController as! ItemDetailViewController
      controller.delegate = self
      
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
      {
        controller.itemToEdit = items[indexPath.row]
      }
    }
  }
  
  func documentsDirectory() -> URL
  {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
//  func dataFilePath(_ i: Int) -> URL
//  {
//    return documentsDirectory().appendingPathComponent("Checklists"+String(i)+".plist")
//  }
  
  func loadChecklistItems()
  {
//    let url = NSURL(string: path)
//    var path = dataFilePath(url)
   if let path = pathOfItems
   {
   
    if let data = try? Data(contentsOf: path)
    {
      let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
      items = unarchiver.decodeObject(forKey: "ChecklistItems") as! [ChecklistItem]
      unarchiver.finishDecoding()
    }
   
   }
  }
  
  func saveChecklistItems()
  {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWith: data)
    archiver.encode(items, forKey: "ChecklistItems")
    archiver.finishEncoding()
    data.write(to: pathOfItems!, atomically: true)
    
  }
}
