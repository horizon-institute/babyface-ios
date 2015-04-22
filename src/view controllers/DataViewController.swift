//
//  DataViewController.swift
//  babyface
//
//  Created by Kevin Glover on 16/04/2015.
//  Copyright (c) 2015 Horizon. All rights reserved.
//

import Foundation
import UIKit

class DataViewController: PageViewController, UITextFieldDelegate
{
	@IBOutlet weak var birthText: UILabel!
	@IBOutlet weak var dueText: UILabel!
	@IBOutlet weak var weightField: UITextField!
	@IBOutlet weak var nextButton: UIButton!
	@IBOutlet weak var genderSelect: UISegmentedControl!
	@IBOutlet weak var ageSlider: UISlider!
	@IBOutlet weak var dueSlider: UISlider!
	@IBOutlet weak var ethnicitySelect: UISegmentedControl!
	
	override var nextPage: Bool
		{
			return nextButton.enabled
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		if pageController?.babyData.weight != 0
		{
			weightField.text = "\(pageController!.babyData.weight)"
		}
		
		if pageController?.babyData.gender == "Girl"
		{
			genderSelect.selectedSegmentIndex = 0
		}
		else if pageController?.babyData.gender == "Boy"
		{
			genderSelect.selectedSegmentIndex = 1
		}
		
		
		if pageController?.babyData.ethnicity == "White"
		{
			ethnicitySelect.selectedSegmentIndex = 0
		}
		else if pageController?.babyData.ethnicity == "Asian"
		{
			ethnicitySelect.selectedSegmentIndex = 1
		}
		else if pageController?.babyData.ethnicity == "Black"
		{
			ethnicitySelect.selectedSegmentIndex = 2
		}
		else if pageController?.babyData.ethnicity == "Mixed"
		{
			ethnicitySelect.selectedSegmentIndex = 3
		}
		else if pageController?.babyData.ethnicity == "Other"
		{
			ethnicitySelect.selectedSegmentIndex = 4
		}
		
		ageSlider.value = Float(-(pageController!.babyData.age))
		dueSlider.value = Float(pageController!.babyData.due)	
		birthChanged(ageSlider)
		dueDateChanged(dueSlider)
		
		weightField.delegate = self
		
		update()
	}
	
	@IBAction func birthChanged(sender: AnyObject)
	{
		if let slider = sender as? UISlider
		{
			var value = Int(-slider.value)
			pageController?.babyData.age = value
			if value == 0
			{
				birthText.text = "Born today"
			}
			else if value == -1
			{
				birthText.text = "Born 1 day ago"
			}
			else
			{
				birthText.text = "Born \(value) days ago"
			}
		}
	}
	
	@IBAction func weightChanged(sender: AnyObject)
	{
		let formatter = NSNumberFormatter()
		if let weight = formatter.numberFromString(weightField.text)?.floatValue
		{
			pageController?.babyData.weight = weight
		}
		update()
	}
	
	@IBAction func dueDateChanged(sender: AnyObject)
	{
		if let slider = sender as? UISlider
		{
			var value = Int(slider.value)
			pageController?.babyData.due = value
			if value == -1
			{
				dueText.text = "Born 1 day early"
			}
			else if value == 1
			{
				dueText.text = "Born 1 day late"
			}
			else if value == 0
			{
				dueText.text = "Born on due date"
			}
			else if value < 0
			{
				dueText.text = "Born \(-value) days early"
			}
			else
			{
				dueText.text = "Born \(value) days late"
			}
		}
	}
	
	@IBAction func genderChanged(sender: AnyObject)
	{
		if let segment = sender as? UISegmentedControl
		{
			pageController?.babyData.gender = segment.titleForSegmentAtIndex(segment.selectedSegmentIndex)!
		}
		update()
	}
	
	@IBAction func ethnicityChanged(sender: AnyObject)
	{
		if let segment = sender as? UISegmentedControl
		{
			pageController?.babyData.ethnicity = segment.titleForSegmentAtIndex(segment.selectedSegmentIndex)!
		}
	}
	
	func endEditingNow()
	{
		let formatter = NSNumberFormatter()
		if let weight = formatter.numberFromString(weightField.text)?.floatValue
		{
			pageController?.babyData.weight = weight
		}
		self.view.endEditing(true)
		update()
	}
	
	func update()
	{
		var enabled = pageController?.babyData.gender != nil && pageController?.babyData.weight != 0
		if enabled != nextButton.enabled
		{
			nextButton.enabled = enabled
			//pageController?.refresh()
		}
	}
	
	// When clicking on the field, use this method.
	func textFieldShouldBeginEditing(textField: UITextField) -> Bool
	{
		if UIDevice.currentDevice().userInterfaceIdiom != .Pad
		{
			// Create a button bar for the number pad
			let keyboardDoneButtonView = UIToolbar()
			keyboardDoneButtonView.sizeToFit()
			
			// Setup the buttons to be put in the system.
			let flexibleItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
			let item = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("endEditingNow") )
			var toolbarButtons = [flexibleItem, item]
			
			//Put the buttons into the ToolBar and display the tool bar
			keyboardDoneButtonView.setItems(toolbarButtons, animated: false)
			textField.inputAccessoryView = keyboardDoneButtonView
		}
		
		return true
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool
	{
		//delegate method
		textField.resignFirstResponder()
		return true
	}
}