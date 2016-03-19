//
//  MassConverterController.swift
//  Converter
//
//  Created by Uday Kumar Reddy Vatti on 3/14/16.
//  Copyright (c) 2016 Uday Kumar Reddy Vatti. All rights reserved.
//

import UIKit

//
// Conversion functions
//

extension String{
    func rangeFromNSRange(nsRange: NSRange) -> Range<String.Index>? {
        let from16 = advance(utf16.startIndex, nsRange.location, utf16.endIndex)
        let to16 = advance(from16, nsRange.length, utf16.endIndex)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self){
                return from..<to
        }
        return nil
    }
}


class MassConverterController: UIViewController, UITextFieldDelegate {

    //
    // Outlet and Actions for the application

    @IBOutlet weak var unit1: UILabel!
    @IBOutlet weak var unit2: UILabel!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var factorofUnit:Double = 0.0
    
    
    //  
    //changing the lables when the segment is changed
    //
    
    @IBAction func indexChanged(sender: AnyObject) {
        
        switch segmentedControl.selectedSegmentIndex{
            
        case 0:
            
            unit1.text = "Mass in Pounds"
            unit2.text = "Mass in Kilograms"
            output.text = "0"
            
        case 1:
            
            unit1.text = "Mass in Kilograms"
            unit2.text = "Mass in Pounds"
            output.text = "0"
            
        default:
            
            break
        }
    }
    
    // clearing the text fields
    
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
            
            factorofUnit = 0.453592
            
        case 1:
            
            factorofUnit = 2.20462
            
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
            var numberformatter = NSNumberFormatter()
            numberformatter.numberStyle = NSNumberFormatterStyle.DecimalStyle

            if let final = numberformatter.stringFromNumber(input.text.toDouble()! * factorofUnit){
                
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

