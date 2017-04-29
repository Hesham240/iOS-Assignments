//
//  FirstViewController.swift
//  V.MEMORY
//
//  Created by Hesham Mohamad on 4/21/17.
//  Copyright © 2017 Hesham Mohamad. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController
{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //view.endEditing(true)
        self.txtfield.resignFirstResponder()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.GoBtn.isEnabled = false
        self.GoBtn.backgroundColor = UIColor.lightGray
        self.GoBtn.layer.cornerRadius =  5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func txtEntered(_ sender: Any)
    {
        
        if Int(txtfield.text!) != nil
        {
            self.GoBtn.isEnabled = true;
            self.GoBtn.backgroundColor = UIColor.green
        }
        else
        {
            self.GoBtn.isEnabled = false
            self.GoBtn.backgroundColor = UIColor.lightGray
        }
        
        

    }
    @IBAction func GoButtonAction(_ sender: Any)
    {

        
        let _number = Int(txtfield.text!)!
        
        // sender info to pass.
        performSegue(withIdentifier: "goaheahSegue", sender: _number)
        
    }
    @IBOutlet weak var txtfield: UITextField!
    @IBOutlet weak var GoBtn: UIButton!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let dist22 = segue.destination as? ViewControllersecond
        {
            if let name  = sender as? Int
            {
                dist22.numOfImages = name;
            }
        }
        
    }

}
