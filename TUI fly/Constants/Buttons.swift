//
//  Buttons.swift
//  TUI fly
//
//  Created by Aaron Taylor on 09/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import SwiftUI

struct CustomButton: View {
    
    var text: String
    var action: () -> Void
    var height = CGFloat(40)
    var textColor = Color.white
    var fontWeight = Font.Weight.semibold
    var backgroundColor = Color.tuiDarkBlue
    
    var body: some View {
                
        Button(action: {
            self.action()
        }) {
            HStack {
                Spacer()
                Text(text)
                    .fontWeight(fontWeight)
                    .foregroundColor(textColor)
                    .frame(height: height)
                Spacer()
            }
            .background(backgroundColor)
        }
    }
}
