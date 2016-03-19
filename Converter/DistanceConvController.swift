//
//  DistanceConvController.swift
//  Converter
//
//  Created by Uday Kumar Reddy Vatti on 3/14/16.
//  Copyright (c) 2016 Uday Kumar Reddy Vatti. All rights reserved.
//

import UIKit


class DistanceConvController: UIViewController, UITextFieldDelegate {
    
    //
    // Outlet and Action for the outlets
    //
    
    @IBOutlet weak var unit1: UILabel!
    @IBOutlet weak var unit2: UILabel!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var factorofUnit:Double = 0.0
    
    //
    //change the lables when the segment is changed
    //
    
    @IBAction func indexChanged(sender: AnyObject) {
        
        switch segmentedControl.selectedSegmentIndex{
            
        case 0:
            
            unit1.text = "Distance in Miles"
            unit2.text = "Distance in Kilometers"
            output.text = "0"
            
        case 1:
            
            unit1.text = "Distance in Kilometers"
            unit2.text = "Distance in Miles"
            output.text = "0"
            
        default:
            
            break
        }

    }
    
    // clear the text fields
    
    @IBAction func clear(sender: AnyObject) {
        
        input.text = ""
        output.text = "0"
    }
    
    
    //
    //conversion of values depending upon the selected segment and input validation
    //
    
    @IBAction func convert(sender: AnyObject) {
        
        switch segmentedControl.selectedSegmentIndex{
            
        case 0:
            
            factorofUnit = 1.60934
            
        case 1:
            
            factorofUnit = 0.621371
            
        default:
            
            break
        }
        
        //through an alert box if input is invalid
        
        if input.text.isEmpty{
            let alert = UIAlertView(title: "Error", message: "Please enter a valid number", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else
        {
            var formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
            
            if let final = formatter.stringFromNumber(input.text.toDouble()! * factorofUnit){
                
                output.text = final
            }
        }

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    //MARK: UITextFieldDelegate
    //
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //
    //validate text field input as floating-point number
    //
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let swRange = textField.text.rangeFromNSRange(range){
            
            var temp = textField.text
            temp.replaceRange(swRange, with: string)
            
            if temp.isEmpty{
                return true
            }
            
            var formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
            
            if let result = formatter.numberFromString(temp){
                return true
            }
            else
            {
                return false
            }
            
        }
        return false
    }
}