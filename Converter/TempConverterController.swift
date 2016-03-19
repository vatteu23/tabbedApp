//
//  TempConverterController.swift
//  Converter
//
//  Created by Uday Kumar Reddy Vatti on 3/14/16.
//  Copyright (c) 2016 Uday Kumar Reddy Vatti. All rights reserved.
//

import UIKit

class TempConverterController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //
    // Outlets and Actions for the application
    //
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var tempPick: UIPickerView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var fahren = Array(-129...134)
    var centi = Array(-90...57)

    //
    //reload the picker view and change the label on segment change
    //
    
    @IBAction func indexChanged(sender: AnyObject) {
        tempPick.reloadAllComponents()
        convert()
    }
    
    //
    //convert the input value and display the output depending 
    //upon the selected value in the picker view
    //
    
    func convert(){
        
        var index = tempPick.selectedRowInComponent(0)
        switch segmentedControl.selectedSegmentIndex{
            
        case 0:
            
            output.text = "\((fahren[index]-32)*5/9) \u{00B0}C"
            
        case 1:
            
            output.text = "\((centi[index]*9/5)+32) \u{00B0}F"
            
        default:
            break;
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        convert()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UIPickerViewDataSource methods.
    //
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int{
            
            switch segmentedControl.selectedSegmentIndex{
                
            case 0:
                return fahren.count
                
            case 1:
                return centi.count
                
            default:
                
                break;
                
            }
           return 0
    }
    
    //
    // MARK: UIPickerViewDelegate methods.
    //
    func pickerView(pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int) -> String?{
            
            switch segmentedControl.selectedSegmentIndex{
                
            case 0:
                return "\(fahren[row]) \u{00B0}F"
                
            case 1:
                return "\(centi[row]) \u{00B0}C"
                
            default:
                
                break;
                
            }
            
            return "0"
    }
    
    func pickerView(pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int){
            
            var val:Int = 0
            
            switch segmentedControl.selectedSegmentIndex{
                
            case 0:
                val = (fahren[row]-32)*5/9
                output.text = "\(val) \u{00B0}C"
                
            case 1:
                val = (centi[row]*9/5)+32
                output.text = "\(val) \u{00B0}F"
                
            default:
                
                break;
                
            }
    }
    
}

