//
//  CustomSlider.swift
//  CustomStepSlider
//
//  Created by Usue on 9/12/15.
//  Copyright © 2015 Usue. All rights reserved.
//

import UIKit

protocol CustomSliderDelegate {
    func sliderValueChanged(value: Float)
}

struct SliderConstants {
    static let kStespHeight = CGFloat(30)
    static let kSliderHeight = CGFloat(55)
    static let kSliderMargin = CGFloat(0)
    static let kYSteps = CGFloat(28)
    static let kSliderColor = UIColor(red: 0.59, green: 0.78, blue: 0.28, alpha: 0.9)
}

class CustomSlider: UIView
{
    @IBOutlet var sliderHeight: NSLayoutConstraint?
    
    private var delegate: CustomSliderDelegate?
    private var slider: UISlider?
    private var stepsView: UIView?
    
    private var numSteps = 0
    private var steps: NSArray
    private var thumbName: String = "slider_selector@2x.png"
    
    //MARK - Public Methods
    
    func setDelegate(delegate: CustomSliderDelegate)
    {
        self.delegate = delegate
    }
    
    func setSteps(steps: NSArray)
    {
        self.steps = steps
        self.numSteps = steps.count
        
        initUIElements()
    }
    
    func setThumbImage(imageName: String)
    {
        thumbName = imageName
        slider?.setThumbImage(UIImage(named: thumbName), for:UIControl.State.normal)
    }
    
    
    //MARK - Initializers
    
    required init?(coder aDecoder: NSCoder)
    {
        steps = NSArray()
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    
    //MARK Functionality Methods
    
    @objc func sliderValueChanged()
    {
        slider!.value = Float(lroundf(slider!.value))
        
        if delegate != nil {
            delegate?.sliderValueChanged(value: slider!.value)
        }
    }
    
    
    //MARK UI Methods
    
    private func initUIElements()
    {
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: SliderConstants.kSliderHeight))
        stepsView = UIView(frame: CGRect(x: 0, y: SliderConstants.kSliderHeight, width: frame.size.width, height: SliderConstants.kStespHeight))
        
        addSubview(slider!)
        configureSliderValues()
        
        addSubview(stepsView!)
        createSteps()
        
        sliderHeight?.constant = SliderConstants.kSliderHeight + SliderConstants.kStespHeight
    }
    
    private func configureSliderValues()
    {
        slider!.minimumValue = 1
        slider!.maximumValue = Float(numSteps)
        slider!.value = Float(numSteps) - 1.0
        
        slider?.tintColor = SliderConstants.kSliderColor
        slider?.addTarget(self, action: #selector(CustomSlider.sliderValueChanged), for: UIControl.Event.touchUpInside)
        slider!.setThumbImage(UIImage(named: thumbName), for:UIControl.State.normal)
    }
    
    private func createSteps()
    {
        for step in steps {
            createLabelForStep(step: step as! String)
        }
    }
    
    private func createLabelForStep(step: String)
    {
        let index = steps.index(of: step)
        let labelWidth = (stepsView!.frame.size.width - (SliderConstants.kSliderMargin*2))/CGFloat(numSteps)
        let label = UILabel(frame: CGRect(origin: CGPoint(x: labelWidth*CGFloat(index) + SliderConstants.kSliderMargin, y: 0), size: CGSize(width: labelWidth, height: 21)))
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textColor = UIColor.black
        label.text = step
        label.textAlignment = NSTextAlignment.center
        
        stepsView!.addSubview(label)
    }
}
