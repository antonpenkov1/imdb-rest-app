//
//  Constants.swift
//  IMDb REST API
//
//  Created by Антон Пеньков on 13.03.2023.
//

import UIKit


enum Constants {
    enum Colors {
        static var gray01: UIColor? {
            UIColor(named: "systemGrayColor")
        }
        
        static var gray03: UIColor? {
            UIColor(named: "systemGrayColor3")
        }
        
        static var black: UIColor? {
            UIColor(named: "Black")
        }
    }
    
    enum Fonts {
        static var ui16semi: UIFont? {
            UIFont.systemFont(ofSize: 16, weight: .semibold)
        }
        
        static var ui14regular: UIFont? {
            UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
    
    enum Image {
        static var image: UIImage? {
            UIImage(named: "Image")
        }
    }
}
