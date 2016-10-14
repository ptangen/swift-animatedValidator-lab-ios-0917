//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    var emailValid = false
    var emailConfirmationValid = false
    var phoneValid = false
    var passwordValid = false
    var passwordConfirmValid = false
    
    var submitButtonBottomConstraint: NSLayoutConstraint!
    var submitButtonTopConstraint: NSLayoutConstraint!
    
    private var currentTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        
        // set delegates
        self.emailTextField.delegate = self
        self.emailConfirmationTextField.delegate = self
        self.phoneTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordConfirmTextField.delegate = self
        
        // set tags
        self.emailTextField.tag = 100
        self.emailConfirmationTextField.tag = 101
        self.phoneTextField.tag = 102
        self.passwordTextField.tag = 103
        self.passwordConfirmTextField.tag = 104
        
        
        // email
        self.emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        self.emailTextField.topAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.emailTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:50).isActive = true
        self.emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // email confirm
        self.emailConfirmationTextField.widthAnchor.constraint(equalTo: self.emailTextField.widthAnchor).isActive = true
        self.emailConfirmationTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 20).isActive = true
        self.emailConfirmationTextField.leftAnchor.constraint(equalTo: self.emailTextField.leftAnchor).isActive = true
        self.emailConfirmationTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // phone
        self.phoneTextField.widthAnchor.constraint(equalTo: self.emailConfirmationTextField.widthAnchor).isActive = true
        self.phoneTextField.topAnchor.constraint(equalTo: self.emailConfirmationTextField.bottomAnchor, constant: 20).isActive = true
        self.phoneTextField.leftAnchor.constraint(equalTo: self.emailConfirmationTextField.leftAnchor).isActive = true
        self.phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // password
        self.passwordTextField.widthAnchor.constraint(equalTo: self.phoneTextField.widthAnchor).isActive = true
        self.passwordTextField.topAnchor.constraint(equalTo: self.phoneTextField.bottomAnchor, constant: 20).isActive = true
        self.passwordTextField.leftAnchor.constraint(equalTo: self.phoneTextField.leftAnchor).isActive = true
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // password confirm
        self.passwordConfirmTextField.widthAnchor.constraint(equalTo: self.passwordTextField.widthAnchor).isActive = true
        self.passwordConfirmTextField.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 20).isActive = true
        self.passwordConfirmTextField.leftAnchor.constraint(equalTo: self.passwordTextField.leftAnchor).isActive = true
        self.passwordConfirmTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // submit button
        self.submitButtonTopConstraint = self.submitButton.topAnchor.constraint(equalTo: self.passwordConfirmTextField.bottomAnchor, constant: 20)
        self.submitButtonBottomConstraint = self.submitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
        self.submitButtonBottomConstraint.isActive = true
        self.submitButton.leftAnchor.constraint(equalTo: self.passwordConfirmTextField.leftAnchor, constant: 20).isActive = true
        self.submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.submitButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag {
            
        case 100:   // check to see if email address contains "@" and "."
            let requiredStringCharSet1 = CharacterSet(charactersIn: "@")
            let requiredStringCharSet2 = CharacterSet(charactersIn: ".")
            if (emailTextField.text!.rangeOfCharacter(from: requiredStringCharSet1 as CharacterSet) != nil) && (emailTextField.text!.rangeOfCharacter(from: requiredStringCharSet2 as CharacterSet) != nil) {
                emailValid = true
            } else {
                emailValid = false
                indicateError(fieldName: self.emailTextField)
            }
        case 101:   // check to see if email confirmation text matches email text
            if (emailTextField.text! == emailConfirmationTextField.text!) {
                emailConfirmationValid = true
            } else {
                emailConfirmationValid = false
                indicateError(fieldName: self.emailConfirmationTextField)
            }
        case 102:   // verify that phone number field does not contain letters or punctuation chars and contains 7 digits
            var requiredStringCharSet = CharacterSet.letters
            requiredStringCharSet.formUnion(CharacterSet.punctuationCharacters) // forms set of illegal characters
            if !(phoneTextField.text!.rangeOfCharacter(from: requiredStringCharSet) != nil) && phoneTextField.text!.utf16.count >= 7 {
                phoneValid = true
            } else {
                phoneValid = false
                indicateError(fieldName: self.phoneTextField)
            }
        case 103: // verify password >= 6 characters
            if passwordTextField.text!.utf16.count >= 6 {
                passwordValid = true
            } else {
                passwordValid = false
                indicateError(fieldName: self.passwordTextField)
            }
        case 104:   // check to see if password confirmation text matches password text
            if (passwordTextField.text! == passwordConfirmTextField .text!) {
                passwordConfirmValid = true
            } else {
                passwordConfirmValid = false
                indicateError(fieldName: self.passwordConfirmTextField)
            }
            
        default: break
        }
        
        print("\nemailValid: \(emailValid)")
        print("emailConfirmationValid: \(emailConfirmationValid)")
        print("phoneValid: \(phoneValid)")
        print("passwordValid: \(passwordValid)")
        print("passwordConfirmValid: \(passwordConfirmValid)")
        
        // check to see if all fields contain valid inputs
        if emailValid && emailConfirmationValid && phoneValid && passwordValid && passwordConfirmValid {
            print("all fields are valid.")
            UIView.animate(withDuration: 2) {
                self.submitButton.isEnabled = true
                self.submitButtonBottomConstraint.isActive = false
                self.submitButtonTopConstraint.isActive = true
                self.view.layoutIfNeeded()
            }
        } else {
            self.submitButton.isEnabled = false
            self.submitButtonBottomConstraint.isActive = true
            self.submitButtonTopConstraint.isActive = false
            self.view.layoutIfNeeded()
        }
    }
    
    func indicateError(fieldName textFieldWithError: UITextField){
        UIView.animate(withDuration: 1, animations: {
            textFieldWithError.backgroundColor = UIColor.red
            textFieldWithError.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { success in
                UIView.animate(withDuration: 1, animations: {  // reset control to original state
                    textFieldWithError.backgroundColor = UIColor.white
                    textFieldWithError.transform = CGAffineTransform(scaleX: 1.0, y:1.0)
                })
        })
    }
}

// .becomeFirstResponder // gives focus and brings up keyboard if its a text field
//  .resignFirstResponder  // hides keyboard for text field.

//  .transform = CGAffineTransform(ScaleX: 2.0, y:2.0)
