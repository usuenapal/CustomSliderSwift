//
//  CustomSlider.swift
//  CustomStepSlider
//
//  Created by Usue on 9/12/15.
//  Copyright © 2015 Usue. All rights reserved.
//

import UIKit

struct SliderConstants {
    static let kSLIDER_HEIGHT = CGFloat(55)
    static let kSLIDER_MARGIN = CGFloat(0)
    static let kY_STEPS = CGFloat(28)
    static let kSLIDER_COLOR = UIColor(red: 0.59, green: 0.78, blue: 0.28, alpha: 0.9)
}

class CustomSlider: UIViewController
{
    @IBOutlet weak var slider: UISlider?
    @IBOutlet weak var stepsView: UIView?
    
    var numSteps = 0
    var steps: NSArray
    
    init(steps: NSArray)
    {
        self.steps = steps
        self.numSteps = steps.count
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.configureSliderValues()
        self.createSteps()

        slider!.setThumbImage(UIImage(named: "slider_selector@2x.png"), forState:UIControlState.Normal)
    }
    
    
    //MARK Functionality Methods
    
    @IBAction func sliderValueChanged()
    {
        slider!.setValue(round(slider!.value), animated: false)
    }
    
    
    //MARK UI Methods
    
    func configureSliderValues()
    {
        slider!.minimumValue = 1
        slider!.maximumValue = Float(numSteps)
        slider!.value = Float(numSteps) - 1.0
        
        self.slider?.tintColor = SliderConstants.kSLIDER_COLOR
        self.slider?.addTarget(self, action: "sliderValueChanged", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func createSteps()
    {
        stepsView?.frame.size = CGSizeMake(UIScreen.mainScreen().bounds.size.width, SliderConstants.kSLIDER_HEIGHT)
    
        for step in steps {
            self.createLabelForStep(step as! String)
        }
    }
    
    func createLabelForStep(step: String)
    {
        let index = steps.indexOfObject(step)
        let labelWidth = (stepsView!.frame.size.width - (SliderConstants.kSLIDER_MARGIN*2))/CGFloat(numSteps)
    
        let label = UILabel(frame: CGRectMake(labelWidth*CGFloat(index) + SliderConstants.kSLIDER_MARGIN, SliderConstants.kY_STEPS, labelWidth, 21))
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textColor = UIColor.blackColor()
        label.text = step
        label.textAlignment = NSTextAlignment.Center
        
        stepsView!.addSubview(label)
    }
}
