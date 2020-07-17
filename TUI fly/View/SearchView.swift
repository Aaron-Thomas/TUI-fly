//
//  SearchView.swift
//  TUI fly
//
//  Created by Aaron Taylor on 09/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    @ObservedObject var searchInput: SearchInput
    
    var body: some View {
        
        VStack {
            SearchHeader(viewModel: viewModel, searchInput: searchInput)
            ConnectionList(viewModel: viewModel, searchInput: searchInput)
        }
    }
}

struct SearchHeader: View {
    
    @ObservedObject var viewModel: SearchViewModel
    @ObservedObject var searchInput: SearchInput
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "xmark")
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
                Text("Flying \(String(describing: searchInput.selectedDirection))")
                    .foregroundColor(Color.white)
                Spacer()
            }
            SearchTextField(viewModel: viewModel)
        }
        .modifier(HeaderModifier())
    }
}

struct SearchTextField: View {
    
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        
        Group {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.tuiLightBlue)
                TextField("Search", text: $viewModel.searchText)
                    .frame(minHeight: CGFloat(30))
                if viewModel.searchText.count >= 1 {
                    Button(action: {
                        self.viewModel.searchText = ""
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(Color.tuiLightBlue)
                    })
                }
            }
            .frame(height: 5)
            .padding()
        }
        .background(Color.white)
        .frame(height: 40)
    }
}


struct ConnectionList: View {
    
    @ObservedObject var viewModel: SearchViewModel
    @ObservedObject var searchInput: SearchInput
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.filteredDestinations(searchInput: searchInput), id: \.self) { destination in
                    ConnectionRow(viewModel: self.viewModel, destination: destination, searchInput: self.searchInput)
                }
            }
        }
        .padding()
    }
}

struct ConnectionRow: View {
    
    @ObservedObject var viewModel: SearchViewModel
    var destination: String
    @ObservedObject var searchInput: SearchInput
    
    var body: some View {
        HStack {
            Text(destination)
            Spacer()
        }.onTapGesture {
            self.updateSearchInput()
        }
    }
    
    func updateSearchInput() {
        if self.searchInput.selectedDirection == .from {
            self.searchInput.fromDestination = self.destination
        } else {
            self.searchInput.toDestination = self.destination
        }
        self.searchInput.showSearchView = false
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel(connections: [Connection]()), searchInput: SearchInput())
    }
}
