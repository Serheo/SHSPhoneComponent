//
//  PhoneViewController.swift
//  PhoneEmbeddedExample
//
//  Created by Will on 20/01/15.
//  Copyright (c) 2015 SHS. All rights reserved.
//

import UIKit

import SHSPhoneComponent

class PhoneViewController: UIViewController {

    @IBOutlet weak var phoneField: SHSPhoneTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneField.becomeFirstResponder()

        defaultExample()
//        prefixExample()
//        doubleFormatExaple()
//        prefixExample()
        
        phoneField.hasPredictiveInput = true;
        phoneField.textDidChangeBlock = { (textField: UITextField!) -> Void in
            print("number is \(textField.text ?? "")")
        }

    }

    //MARK: Examples
    
    func defaultExample() {
        phoneField.formatter.setDefaultOutputPattern("+# (###) ###-##-##")
    }
    
    func prefixExample() {
        phoneField.formatter.setDefaultOutputPattern("##########")
        phoneField.formatter.prefix = "+7 "
        phoneField.formatter.addOutputPattern("(###) ###-##-##", forRegExp: "^[0-689]\\d*$", imagePath:"SHSPhoneImage.bundle/flag_ru")
    }
    
    func doubleFormatExaple() {
        phoneField.formatter.setDefaultOutputPattern("##########")
        phoneField.formatter.prefix = nil
        phoneField.formatter.addOutputPattern("+# (###) ###-##-##", forRegExp: "^7[0-689]\\d*$", imagePath:"SHSPhoneImage.bundle/flag_ru")
        phoneField.formatter.addOutputPattern("+### ###-##-##", forRegExp: "^380\\d*$", imagePath:"SHSPhoneImage.bundle/flag_ua")
    }
    
    func doubleFormatExamplePrefixed() {
        phoneField.formatter.setDefaultOutputPattern("### ### ###")
        phoneField.formatter.prefix = "+7 "
        phoneField.formatter.addOutputPattern("(###) ###-##-##", forRegExp: "^1\\d*$", imagePath:"SHSPhoneImage.bundle/flag_ru")
        phoneField.formatter.addOutputPattern("(###) ###-###", forRegExp: "^2\\d*$", imagePath:"SHSPhoneImage.bundle/flag_ua")
    }

}
