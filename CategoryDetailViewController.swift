import Foundation
import UIKit

protocol CategoryDetailViewControllerDelegate: class
{
  func categoryDetailViewControllerDidCancel(_ controller: CategoryDetailViewController)
  func categoryDetailViewController(_ controller: CategoryDetailViewController,
                                didFinishAdding item: CustomCategoryList)
  func categoryDetailViewController(_ controller: CategoryDetailViewController,
                                didFinishEditing item: CustomCategoryList)
}

class CategoryDetailViewController: UITableViewController, UITextFieldDelegate,chooseImageViewControllerDelegate
{
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  weak var delegate: CategoryDetailViewControllerDelegate?
  
  var categoryToEdit: CustomCategoryList?
  
  var chosenImage = "No Icon"
  

  
  func itemDetailViewController(_ controller: ChooseIconTableViewController, didFinishChoosing item: String)
  {
    chosenImage = item
  }
  
  
  
  
  
  
  
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    
    
    
    if let category = categoryToEdit
    {
      title = "Edit Category"
      textField.text = category.listName
      doneBarButton.isEnabled = true
    }
  }
  
  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  override func viewDidAppear(_ animated: Bool)
  {
    self.tableView.cellForRow(at: IndexPath(row: 0,section: 1))?.imageView?.image = UIImage(named: chosenImage)
    self.tableView.cellForRow(at: IndexPath(row: 0,section: 1))?.textLabel?.text = "Choose an Icon"
    self.tableView.cellForRow(at: IndexPath(row: 0,section: 1))?.detailTextLabel?.text = ""
    
    
  }
  
  @IBAction func cancel()
  {
    delegate?.categoryDetailViewControllerDidCancel(self)
  }
  
  @IBAction func done()
  {
    if let item = categoryToEdit
    {
      item.listName = textField.text!
      item.iconName = chosenImage
      delegate?.categoryDetailViewController(self, didFinishEditing: item)
      
    } else
    {
      let item = CustomCategoryList()
      item.listName = textField.text!
      item.iconName = chosenImage
      delegate?.categoryDetailViewController(self, didFinishAdding: item)
    }
  }
  
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//  {
//    let cell = tableView.cellForRow(at: indexPath)
//    
//    if(indexPath.section == 1)
//    {
//      cell?.imageView?.image = UIImage(named: chosenImage)
//      cell?.textLabel?.text = "Choose an Icon"
//      cell?.detailTextLabel?.text = ""
//      
//      //self.tableView.cellForRow(at: IndexPath(row: 0,section: 1))?.imageView?.image = UIImage(named: chosenImage)
//      return cell!
//      //performSegue(withIdentifier: "chooseIcon", sender: self)
//    }
//    else
//    {
//      cell?.addSubview(self.textField)
//    }
//    
//    return cell!
//  }
  
  
  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath)
  {
    
    self.textField.resignFirstResponder()
  
    
    if(indexPath.section == 1)
    {
      self.tableView.cellForRow(at: IndexPath(row: 0,section: 1))?.imageView?.image = UIImage(named: chosenImage)
      performSegue(withIdentifier: "chooseIcon", sender: self)
    }
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "chooseIcon"
    {
      let navigationController = segue.destination as! UINavigationController
      let controller = navigationController.topViewController as! ChooseIconTableViewController
      controller.delegate = self
      
    }
  }

  
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool
  {
    
    let oldText = textField.text! as NSString
    let newText = oldText.replacingCharacters(in: range, with: string) as NSString
    
    doneBarButton.isEnabled = (newText.length > 0)
    return true
  }
}
