//
//  MainView.swift
//  TUI fly
//
//  Created by Aaron Taylor on 09/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    let tripPlannerViewModel = TripPlannerViewModel()
    
    var body: some View {
        VStack {
            SegmentedControlView(viewModel: viewModel)
            if viewModel.selection == 0 {
                TripPlannerView(viewModel: tripPlannerViewModel)
            } else {
                // TUI Experiences
            }
            Spacer()
        }
        .background(Color.tuiLightBlue.edgesIgnoringSafeArea(.all))
    }
}

struct SegmentedControlView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 0) {
            CustomSegmentedControlButton(viewModel: viewModel, selection: 0, text: "Flights", imageName: "airplane")
            CustomSegmentedControlButton(viewModel: viewModel, selection: 1, text: "TUI Experiences", imageName: "camera")
        }
    }
}

struct CustomSegmentedControlButton: View {
    
    @ObservedObject var viewModel: MainViewModel
    var selection: Int
    var text: String
    var imageName: String
    
    var body: some View {
        
        Button(action: {
            self.viewModel.selection = self.selection
        }, label: {
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.white)
                Text(text)
                    .foregroundColor(Color.white)
                Divider()
                    .frame(height: 2)
                    .background(viewModel.selection == selection ? Color.white : Color.clear)
            }
        })
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
