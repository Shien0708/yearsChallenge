//
//  ViewController.swift
//  yearsChallenge
//
//  Created by 方仕賢 on 2021/12/25.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var autoPlaySwitch: UISwitch!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var yearAndMonthLabel: UILabel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var petImageView: UIImageView!
    
    @IBOutlet weak var yearSlider: UISlider!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    let dateFormatter = DateFormatter()
    
    let background = [1,2,3,4,5,6,7,8,9,10,11,12]
    
    let image = [2011 ,2012 ,2013 ,2014 ,2015 ,2016 ,2017 ,2018 ,2019 ,2020 ,2021]
    
    var backgroundIndex = 0
    
    var imageIndex = 2011
    
    var timer: Timer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        autoPlaySwitch.isOn = false
        petImageView.image = UIImage(named: "\(image[0])")
        yearSlider.value = 2011
        yearLabel.text = "2011"
        yearAndMonthLabel.text = "December/2011"
        backgroundImageView.image = UIImage(named: "\(background[11])")
        
    }
    
    func time() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.next()
        })
    }
    
    func next() {
       if backgroundIndex == background.count-1 {
                backgroundIndex = 0
            } else {
                backgroundIndex += 1
            }
            
        backgroundImageView.image = UIImage(named: "\(background[backgroundIndex])")
            
        
        if imageIndex-2011 == image.count-1 {
            imageIndex = 2011
        } else {
            imageIndex += 1
        }
        
        petImageView.image = UIImage(named: "\(image[imageIndex-2011])")
        
        yearLabel.text = "\(imageIndex)"
        
        let newDatePicker = DateComponents(calendar: Calendar.current, year: imageIndex, month: backgroundIndex).date
        
        datePicker.date = newDatePicker!
        
        dateFormatter.dateFormat = "MMMM/yyyy"
        
        let dateString = dateFormatter.string(from: datePicker.date)
        
        yearAndMonthLabel.text = "\(dateString)"
        
        yearSlider.value = Float(imageIndex)
        
        
        
    }
    
    
    @IBAction func SwitchOnAutoPlay(_ sender: UISwitch) {
        
        if sender.isOn {
            time()
        } else {
            timer?.invalidate()
        }
    }
    
    @IBAction func changeYear(_ sender: UISlider) {
        
        imageIndex = Int(sender.value)
        
        petImageView.image = UIImage(named: "\(image[imageIndex-2011])")
        
        yearLabel.text = "\(imageIndex)"
        
        let newDatePicker = DateComponents(calendar: Calendar.current, year: imageIndex).date
        
        datePicker.date = newDatePicker!
        
        dateFormatter.dateFormat = "MMMM/yyyy"
        
        let dateString = dateFormatter.string(from: datePicker.date)
        
        yearAndMonthLabel.text = "\(dateString)"
        
    }
    
    @IBAction func changeDate(_ sender: Any) {
        dateFormatter.dateFormat = "MMMM/yyyy"
        
        let dateString = dateFormatter.string(from: datePicker.date)
        
        
        
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
        
        
        imageIndex = dateComponents.year!
        
        backgroundIndex = dateComponents.month!
        
        yearSlider.value = Float(imageIndex)
        
        yearLabel.text = "\(String(describing: imageIndex))"
        
        petImageView.image = UIImage(named: String(image[Int(imageIndex-2011)]))
        
        yearAndMonthLabel.text = "\(String(describing: dateString))"
        
        backgroundImageView.image = UIImage(named: String(background[Int(backgroundIndex-1)]))
    
    }
    
}

