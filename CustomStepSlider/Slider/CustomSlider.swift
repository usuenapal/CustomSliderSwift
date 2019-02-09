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

        configureSliderValues()
        createSteps()

        slider!.setThumbImage(UIImage(named: "slider_selector@2x.png"), for:UIControl.State.normal)
    }
    
    
    //MARK Functionality Methods
    
    @IBAction func sliderValueChanged()
    {
        slider!.setValue(round(slider!.value), animated: false)
    }
    
    
    //MARK UI Methods
    
    private func configureSliderValues()
    {
        slider!.minimumValue = 1
        slider!.maximumValue = Float(numSteps)
        slider!.value = Float(numSteps) - 1.0
        
        slider?.tintColor = SliderConstants.kSLIDER_COLOR
        slider?.addTarget(self, action: #selector(CustomSlider.sliderValueChanged), for: UIControl.Event.touchUpInside)
    }
    
    private func createSteps()
    {
        stepsView?.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: SliderConstants.kSLIDER_HEIGHT)
    
        for step in steps {
            createLabelForStep(step: step as! String)
        }
    }
    
    private func createLabelForStep(step: String)
    {
        let index = steps.index(of: step)
        let labelWidth = (stepsView!.frame.size.width - (SliderConstants.kSLIDER_MARGIN*2))/CGFloat(numSteps)
        let label = UILabel(frame: CGRect(origin: CGPoint(x: labelWidth*CGFloat(index) + SliderConstants.kSLIDER_MARGIN, y: SliderConstants.kY_STEPS), size: CGSize(width: labelWidth, height: 21)))
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textColor = UIColor.black
        label.text = step
        label.textAlignment = NSTextAlignment.center
        
        stepsView!.addSubview(label)
    }
}
