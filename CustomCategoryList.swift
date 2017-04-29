//
//  CustomCheckList.swift
//  Checklists
//
//  Created by Hesham Mohamad on 4/27/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import Foundation

private var number: Int = 0;

class CustomCategoryList: NSObject, NSCoding
{
  //static var number = 0
  
  
  
  var listName = ""
  var numberOfItemsInList = 0
  var iconName = "No Icon"
  
  var pathToitems = URL(fileURLWithPath: "")
  
  override init()
  {
    
    number += 1
    
    let documentsURL = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask)[0]
   // fileURL = documentsURL!.URLByAppendingPathComponent(file)
    let fileName = "itemsOfCategory"+String(number)
    let urlpath     = documentsURL.appendingPathExtension(fileName+".plist")
    //let url         = NSURL.fileURL(withPath: urlpath)
    
    pathToitems = urlpath
    
    
    
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    listName = aDecoder.decodeObject(forKey: "listName") as! String
    numberOfItemsInList = aDecoder.decodeInteger(forKey: "numberOfItemsInList")
    iconName = aDecoder.decodeObject(forKey: "iconName") as! String
    pathToitems = aDecoder.decodeObject(forKey:"pathToitems") as! URL
    
    super.init()
  }
  
  
  
  func encode(with aCoder: NSCoder)
  {
    aCoder.encode(listName, forKey: "listName")
    aCoder.encode(numberOfItemsInList, forKey: "numberOfItemsInList")
    aCoder.encode(iconName, forKey:"iconName")    
    aCoder.encode(pathToitems,forKey:"pathToitems")
  }
}

