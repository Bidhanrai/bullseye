//
//  ViewController.swift
//  uikitGame
//
//  Created by nsd mac on 28/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var currentSliderValue: Int = 0
    var targetValue: Int = 0
    var roundValue: Int = 0
    var totalScore: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        currentSliderValue = Int(roundedValue)
        startOver()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    @IBAction func showHitMeAlert() {
        let difference = calcDifference()
        var points = 100 - difference
        
        let title: String
        
        if difference==0 {
            title = "Perfect!"
            points += 100
        }else if difference<5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        }else if difference<10 {
            title = "Preety good!"
        }else {
            title = "Not even close..."
        }
        
        totalScore += points
            
        let message = "You scored \(points)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
       
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        currentSliderValue = Int(roundedValue)
    }
    
    @IBAction func startOver() {
        totalScore = 0
        roundValue = 0
        startNewRound()
    }
    
    func startNewRound() {
        roundValue += 1
        targetValue = Int.random(in: 1...100)
        currentSliderValue = 50
        slider.value = Float(currentSliderValue)
        updateLabels()
    }
    
    func updateLabels() {
        targetValueLabel.text = String(targetValue)
        roundLabel.text = String(roundValue)
        scoreLabel.text = String(totalScore)
    }
    
    func calcDifference()-> Int {
        let diff = abs(targetValue - currentSliderValue)
        return diff
    }

}

