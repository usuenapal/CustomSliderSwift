//
//  ViewController.swift
//  CustomStepSlider
//
//  Created by Usue on 9/12/15.
//  Copyright © 2015 Usue. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CustomSliderDelegate
{
    @IBOutlet var slider: CustomSlider?
    @IBOutlet var slider2: CustomSlider?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        slider?.setDelegate(delegate: self)
        slider?.setSteps(steps: ["1", "2", "3", "4", "5"])
        
        slider2?.setSteps(steps: ["Shit", "Bad", "Disgusting"])
        slider2?.setThumbImage(imageName: "thumb@2x.png")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK - CustomSliderDelegate
    
    func sliderValueChanged(value: Float)
    {
        NSLog("Value changed on custom slider 1: \(value)")
    }
}

