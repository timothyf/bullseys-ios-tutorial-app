//
//  ViewController.swift
//  BullsEye
//
//  Created by Tim Fisher on 12/24/15.
//  Copyright © 2015 Lochbridge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }

    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Pefect!"
            points += 100
        }
        else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        }
        else if difference < 10 {
            title = "Pretty good!"
        }
        else {
            title = "Not even close..."
        }
        score += points

        let message = "You scored \(points) points"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default,
                                   handler: { action in
                                                self.startNewRound()
                                                self.updateLabels()
                                            })
        
        alert.addAction(action)
        
        presentViewController(alert, animated:true, completion: nil)
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
        //print("The value of the slider is now: \(slider.value)")
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}

