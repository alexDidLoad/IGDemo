//
//  AuthenticationViewModel.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/9/21.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}


protocol AuthenticationViewModel {
    var formIsValid           : Bool { get }
    var buttonBackgroundColor : UIColor { get }
    var buttonTitleColor      : UIColor { get }
}

//MARK: - LoginViewModel

struct LoginViewModel: AuthenticationViewModel {
    
    var email    : String?
    var password : String?
    
    var formIsValid : Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.67)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor.white.withAlphaComponent(0.67)
    }
    
}

//MARK: - RegistrationViewModel

struct RegistrationViewModel: AuthenticationViewModel {
    
    var email    : String?
    var password : String?
    var fullname : String?
    var username : String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.67)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor.white.withAlphaComponent(0.67)
    }
    
}
