//
//  ChooseIconTableViewController.swift
//  Checklists
//
//  Created by Hesham Mohamad on 4/28/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit


protocol chooseImageViewControllerDelegate: class
{

  func itemDetailViewController(_ controller: ChooseIconTableViewController,
                                didFinishChoosing item: String)
}



class ChooseIconTableViewController: UITableViewController, UINavigationControllerDelegate
{
  
  var images = ["No Icon","Folder","Appointments","Birthdays","Chores",
                "Drinks","Groceries","Inbox","Photos","Trips"]
  
  var chosenImage = ""
  
  weak var delegate: chooseImageViewControllerDelegate?
  

    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return images.count
  }
  
  @IBAction func Back(_ sender: Any)
  {
    self.dismiss(animated: true, completion: nil)
  }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catImage", for: indexPath)

        // Configure the cell...
      
      let title = images[indexPath.row]
      cell.textLabel?.text = title
      cell.detailTextLabel?.text = ""
      cell.imageView?.image = UIImage(named: title)
 
        return cell
    }
  
  
  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath)
  {
    
    if let cell = tableView.cellForRow(at: indexPath)
    {
      let item = images[indexPath.row] // string
      chosenImage = item
      delegate?.itemDetailViewController(self, didFinishChoosing: item)

  
    }
    tableView.deselectRow(at: indexPath, animated: true)
    
    //performSegue(withIdentifier: "imageChosen", sender: chosenImage)
    
    
    
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let dist22 = segue.destination as? CategoryDetailViewController
    {
      if let name  = sender as? String
      {
        dist22.chosenImage = name;
      }
      
    }
    
  }


}

extension ChooseIconTableViewController
{
  func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController,animated: Bool)
  {
    (viewController as? CategoryDetailViewController)?.chosenImage = chosenImage
  }
  
}














