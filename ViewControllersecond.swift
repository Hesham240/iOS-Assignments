//
//  ViewController.swift
//  V.MEMORY
//
//  Created by Hesham Mohamad on 4/21/17.
//  Copyright © 2017 Hesham Mohamad. All rights reserved.
//

import UIKit

class ViewControllersecond: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource
{

    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var imagesLeft: UILabel!
    
    var stringPassed = "" // ??
    var numOfImages = Int()
    
    @IBOutlet weak var MyCollectionView1: UICollectionView!
    
    var images_set1 = ["AceHearts" ,"AceClubs","AceDiamonds","AceSpades",
                       "TwoHearts" ,"TwoClubs","TwoDiamonds","TwoSpades",
                       "ThreeHearts","ThreeClubs","ThreeDiamond","ThreeSpades",
                       "FourHEarts" , "FourClubs","FourDiamonds","FourSpades",
                        "FiveHearts","FiveClubs","FiveDiamonds","FiveSpades",
                        "SixHearts","SixsClubs","SixDiamonds","SixSpades",
                        "SevenHearts","SevenClubs","SevenDiamonds","SevenSpades",
                        "EightHearts","EightClubs","EightDiamonds","EightSpades",
                        "NineClubs","NineDiamonds","NineSpades","NineHearts",
                        "TenClubs","TenDiamonds","TenSpades","TenHearts",
                        "JackClubs","JackDiamonds","JackSpades","JackHearts",
                        "QueenClubs","QueenDiamonds","QueenSpades","QueenHearts",
                        "KingClubs","KingDiamonds","KingSpade","KingHearts",
                        "JokerSad","Joker2","JokerBlack"]
    
    var image_set2 = ["AceHearts_1" ,"AceClubs_1","AceDiamonds_1","AceSpades_1",
                      "TwoHearts_1" ,"TwoClubs_1","TwoDiamonds_1","TwoSpades_1",
                      "ThreeHearts_1","ThreeClubs_1","ThreeDiamond_1","ThreeSpades_1",
                      "FourHearts_1" , "FourClubs_1","FourDiamonds_1","FourSpades_1",
                      "FiveHearts_1","FiveClubs_1","FiveDiamonds_1","FiveSpades_1",
                      "SixHearts_1","SixsClubs_1","SixDiamonds_1","SixSpades_1",
                      "SevenHearts_1","SevenClubs_1","SevenDiamonds_1","SevenSpades_1",
                      "EightHearts_1","EightClubs_1","EightDiamonds_1","EightSpades_1",
                      "NineClubs_1","NineDiamonds_1","NineSpades_1","NineHearts_1",
                      "TenClubs_1","TenDiamonds_1","TenSpades_1","TenHearts_1",
                      "JackClubs_1","JackDiamonds_1","JackSpades_1","JackHearts_1",
                      "QueenClubs_1","QueenDiamonds_1","QueenSpades_1","QueenHearts_1",
                      "KingClubs_1","KingDiamonds_1","KingSpade_1","KingHearts_1",
                      "Joker_2","Joker_1",]
    
    var backside = ["BackSide","BackSide2"]
    
    var finalImageSet = [String]() // holds the number*2
    var chosenImages = [""] // holds the number
    
    var firstImageSelected = "" //?
    var seconImageSelected = "" //?
    
    var Indx1 : IndexPath?  //?
    var Indx2 : IndexPath?  //?
    
    var FIRST_CELL  : MiiCollectionViewCell?
    var SECOND_CELL : MiiCollectionViewCell?
    
    
    
    
    
    var MyScore = 0
    
 
//--------------------------------------------------------------------
    func prepareImagePool()
    {
        let NUMBEROFIMAGES = numOfImages
        let DOUBLE = NUMBEROFIMAGES * 2
    
        var chosenIndx = [false] // numOfImages *2
        var chosenSet = [Int]() // bcs there wont be image number -1
        
        finalImageSet = Array(repeating: "", count: DOUBLE)

        
        //make it all false---------------------------
        for _ in 1..<DOUBLE
        {
            chosenIndx.append(false)
        }
        
        // fill chosen images--------------------------
        var randomNumber = arc4random_uniform(55)
        chosenImages[0] = images_set1[Int(randomNumber)]
        chosenSet.insert(Int(randomNumber), at:0)
        
        for _ in 1..<NUMBEROFIMAGES
        {
            randomNumber = arc4random_uniform(55)
            while (chosenSet.contains(Int(randomNumber)))
            {
                randomNumber = arc4random_uniform(55)
            }
            chosenImages.append(images_set1[Int(randomNumber)])
            chosenSet.insert(Int(randomNumber), at:chosenSet.count-1)
            
        }
        
      // set the final images---------------------------
        
        for i in 0..<NUMBEROFIMAGES
        {
            let toFill = chosenImages[i]
            
            // put first time
            randomNumber = arc4random_uniform(UInt32(DOUBLE))
            while (chosenIndx[Int(randomNumber)])
            {
                randomNumber = arc4random_uniform(UInt32(DOUBLE))
            }
            finalImageSet[Int(randomNumber)] = toFill
            chosenIndx[Int(randomNumber)] = true;
            
            // put second time
            randomNumber = arc4random_uniform(UInt32(DOUBLE))
            while (chosenIndx[Int(randomNumber)])
            {
                randomNumber = arc4random_uniform(UInt32(DOUBLE))
            }
            
            finalImageSet[Int(randomNumber)] = toFill

            chosenIndx[Int(randomNumber)] = true;
        }
        
    }
//---------------------------------------------------------------------
    func check (_ i1:IndexPath,_ i2: IndexPath)
    {
        let fcell = self.MyCollectionView1.cellForItem(at: i1) as! MiiCollectionViewCell
        let scell = self.MyCollectionView1.cellForItem(at: i2) as! MiiCollectionViewCell
        
        if (fcell.MyCellImageView.image == scell.MyCellImageView.image)
        {
            
            fcell.MyCellImageView.layer.opacity = 0.1
            fcell.MyCellImageView.backgroundColor = UIColor.black
            scell.MyCellImageView.layer.opacity = 0.1
            scell.MyCellImageView.backgroundColor = UIColor.blue
            fcell.isUserInteractionEnabled = false
            scell.isUserInteractionEnabled = false
            
            
            Indx1 = nil
            Indx2 = nil
            
            MyScore += 100;
            self.Score.text = String(MyScore)
            
            
            var lop = Int(self.imagesLeft.text!)
            lop! -= 1
            self.imagesLeft.text = String(lop!)
            
            
            //return true
            
        }
        else
        {
            let beforeImage = UIImage(named: "BackSide")
            
//            UIView.transition(with: fcell.MyCellImageView, duration: 0.7, options: .transitionFlipFromRight, animations: {fcell.MyCellImageView.image = beforeImage}, completion: nil)
//            UIView.transition(with: scell.MyCellImageView, duration: 0.7, options: .transitionFlipFromRight, animations: {scell.MyCellImageView.image = beforeImage}, completion: nil)
            perform(#selector(ViewControllersecond.turnOneOver), with:fcell, afterDelay: 1)
            perform(#selector(ViewControllersecond.turnOneOver), with:scell, afterDelay: 1)
            
            
            Indx1 = nil
            Indx2 = nil
            
            //return false
        }
        
        
        
        //let beforeImage = UIImage(named: "BackSide")
        
       
    }
//******************************************************************************
    func check_Cells(_ i1:MiiCollectionViewCell,_ i2:MiiCollectionViewCell)->Bool
    {
        if(i1.MyCellImageView.image == i2.MyCellImageView.image)
        {
            return true
        }
        else{
        return false
        }
        
    }
    
//******************************************************************************
//-------------------------
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.MyCollectionView1.delegate = self
        self.MyCollectionView1.dataSource = self

        prepareImagePool()
        
        self.imagesLeft.text = String(numOfImages)
        
        
       // perform(#selector(ViewControllersecond.turnAllOver), with:nil, afterDelay: 3)
        
        
    }
    
    
    
    func turnAllOver()
    {
        for cell in self.MyCollectionView1.visibleCells
        {
            
            let idx = self.MyCollectionView1.indexPath(for: cell)!
            let mycell = self.MyCollectionView1.cellForItem(at: idx) as! MiiCollectionViewCell
            let beforeImage = UIImage(named: "BackSide")
            
            UIView.transition(with: mycell.MyCellImageView, duration: 0.7, options: .transitionCrossDissolve, animations: {mycell.MyCellImageView.image = beforeImage}, completion: nil)
            
        }
    }
    
    func turnOneOver(_ cell: UICollectionViewCell)
    {
        
            
            let idx = self.MyCollectionView1.indexPath(for: cell)!
            let mycell = self.MyCollectionView1.cellForItem(at: idx) as! MiiCollectionViewCell
            let beforeImage = UIImage(named: "BackSide")
            
            UIView.transition(with: mycell.MyCellImageView, duration: 0.7, options: .transitionCrossDissolve, animations: {mycell.MyCellImageView.image = beforeImage}, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return numOfImages*2  // ?
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstViewCell", for: indexPath) as! MiiCollectionViewCell
        
        cell.MyCellImageView.image = UIImage(named: finalImageSet[indexPath.row])


        perform(#selector(ViewControllersecond.turnOneOver), with:cell, afterDelay: 3)
        
        return cell
    }
    
    
    //func
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = MyCollectionView1.cellForItem(at: indexPath) as! MiiCollectionViewCell
        
        
        if(cell.MyCellImageView.image == UIImage(named: "BackSide"))
        {
           let beforeImage = UIImage(named: finalImageSet[indexPath.row])
            
            UIView.transition(with: cell.MyCellImageView, duration: 0.7, options: .transitionFlipFromLeft, animations: {cell.MyCellImageView.image = beforeImage}, completion: nil)
        }
        else
        {
            let afterImage = UIImage(named: "BackSide")
            
            UIView.transition(with: cell.MyCellImageView, duration: 0.7, options: .transitionFlipFromRight, animations: {cell.MyCellImageView.image = afterImage}, completion: nil)
        }
        
        
        
        if (FIRST_CELL == nil)
        {
            FIRST_CELL = cell
            Indx1 = indexPath
            
        }
        else if (Indx2 == nil)
        {
            Indx2 = indexPath
            SECOND_CELL = cell
            if(check_Cells(FIRST_CELL!, SECOND_CELL!))
            {
                FIRST_CELL?.MyCellImageView.layer.opacity = 0.1
                SECOND_CELL?.MyCellImageView.layer.opacity = 0.2
                
            
                FIRST_CELL?.isUserInteractionEnabled = false
                SECOND_CELL?.isUserInteractionEnabled = false
                
                MyScore += 100;
                self.Score.text = String(MyScore)
                
                
                var lop = Int(self.imagesLeft.text!)
                lop! -= 1
                self.imagesLeft.text = String(lop!)
                
                FIRST_CELL = nil
                SECOND_CELL = nil
                
                Indx1 = nil
                Indx2 = nil
                
            }
            
            else
            {
                FIRST_CELL = nil
                SECOND_CELL = nil
                
                Indx1 = nil
                Indx2 = nil
            }
            
        }
       
            
            
            //Indx1 = indexPath

    }

    @IBAction func BckBtn(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
  

}

