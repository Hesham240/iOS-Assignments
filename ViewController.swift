/*//
//  ViewController.swift
//
//
//  Created by Hesham Mohamad on 4/8/17.
//  Copyright © 2017 Hesham Mohamad. All rights reserved.
//
 Next steps
 1- regarding speech is either making a bool of funny speeches for each state and choose from it
    randomly
 2- custom made images to illuserate "how to play" and the info button to show/hide it
    or a guesture recognizer to hide the "how to play"
*/

import UIKit
import AVFoundation

class MySlider :UISlider
{
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.size.width, height: 4)
    }

}

class ViewController: UIViewController
{
    var currentValue:Int?
    var targetValue:Int?
    var roundNumber = 1;
    var AT1:String = "Good" // to hold the string for the speech
    var score = 0;
    
    @IBOutlet weak var slider1: MySlider!
    
    @IBOutlet weak var scoreLbl: UILabel!
    
    @IBOutlet weak var numberOfRoundsLbl: UILabel!

    @IBOutlet weak var hitmeBtn: UIButton!
    @IBOutlet weak var targetValueLbl: UILabel!
    
    
   
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Background.png"))
        
        self.hitmeBtn.setBackgroundImage(#imageLiteral(resourceName: "Button-Highlighted.png"), for:UIControlState.highlighted)
        
        self.slider1.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Normal.png"), for: .normal)
        self.slider1.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Highlighted.png"), for: .highlighted)
        
        // image1 and image2 are for the min/max slidertrack
        
        var image1 = UIImage(named: "SliderTrackLeft_mine@2x.png")
        let inset1 = UIEdgeInsets(top: 7, left: 12, bottom: 8, right: 12)
        image1 = image1!.resizableImage(withCapInsets: inset1)
   
        // not the safest choice to force unwrap, but here i am sure
        self.slider1.setMinimumTrackImage(image1!,for: .normal)
        
        
        var image2 = UIImage(named: "SliderTrackRight@2x.png")
        image2 = image2!.resizableImage(withCapInsets: inset1) // same insets
        self.slider1.setMaximumTrackImage(image2,for: .normal)
       
        startNewRound()
        updateLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewRound()
    {
        // to set the default user score for this level
        currentValue = 50
        //reset the slider position
        slider1.setValue(Float(currentValue!), animated: true) 
        //generate new target value
        targetValue = 1 + Int(arc4random_uniform(100))
        
    }
    func updateLabels()
    {
        numberOfRoundsLbl.text = String(roundNumber)
        scoreLbl.text = String(score)
        targetValueLbl.text = String(targetValue!)
    }
    
    func getBonuesAndLbel(_ modules:Int)->(String,Int)
    {
        switch modules {
        case 0:
            return("Perfect!",100)
        case 1...5:
            return("You almost had it!",50)
        case 6...10:
            return("Pretty Good!",0)
            
        default:
            return("Not even close...",0)
        }
        
    }
    
    @IBAction func hitMeButton(_ sender: Any)
    {
        // we make the difference
        let diff = abs(targetValue! - currentValue!) // to ommit the -ve
        let basicScore = 100 - diff
        let(attitude,bonusScore) = getBonuesAndLbel(diff)
        let total = basicScore+bonusScore
        AT1 = attitude
        
        let synth = AVSpeechSynthesizer()
        let myUtterence = AVSpeechUtterance(string: AT1)
        myUtterence.rate = 0.51
        synth.speak(myUtterence)
        
        
        let alert = UIAlertController(title: attitude,
                    message: "You scored:\(total)\nYour value:\(currentValue!)\nYour target was:\(targetValue!)", preferredStyle: .alert)
        
     
        
        alert.addAction(UIAlertAction(title: "Okay,Keep Going!", style: .default, handler: {(alert:UIAlertAction!) in
            self.score+=total;
            self.roundNumber+=1;
            self.startNewRound();
            self.updateLabels()}))
        
        alert.addAction(UIAlertAction(title: "Start Over!", style: .default, handler: {(alert:UIAlertAction!) in self.resetBtnClk(sender)
        }))
        
        present(alert, animated: true,completion:nil)
        

        
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider)
    {
        currentValue = lroundf(slider.value)

    }
    
    @IBAction func resetBtnClk(_ sender: Any)
    {
        score = 0;
        roundNumber = 1;
        currentValue = 50;
        slider1.value = Float(currentValue!)
        targetValue = 1+Int(arc4random_uniform(100))
        
        updateLabels()
    }
    
}

