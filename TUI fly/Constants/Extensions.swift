//
//  Extensions.swift
//  TUI fly
//
//  Created by Aaron Taylor on 11/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import SwiftUI

extension Double {
    
    func currencyFormatted(localeIdentifier: String = "en_GB") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currencyAccounting
        formatter.locale = Locale(identifier: localeIdentifier)
        guard let formattedString = formatter.string(from: NSNumber(value: self)) else { return "" }
        return formattedString
    }
}

struct HeaderModifier: ViewModifier {
    
    var height = CGFloat(100)
    
    func body(content: Content) -> some View {
            content
                .padding(.horizontal)
                .background(Color.tuiLightBlue.edgesIgnoringSafeArea(.all))
                .frame(height: height)
                .background(Color.tuiLightBlue)
    }
}

extension NSError {
    
    static func createError(withMessage message: String) -> NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
