//
//  ResultsView.swift
//  TUI fly
//
//  Created by Aaron Taylor on 11/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import SwiftUI

struct ResultsView: View {
    
    @ObservedObject var viewModel: ResultsViewModel

    var body: some View {
        VStack {
            ResultsHeader()
            ResultsList(viewModel: viewModel)
        }
    }
}

struct ResultsList: View {
    
    @ObservedObject var viewModel: ResultsViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if viewModel.searchResults.isEmpty {
                    Text("There are no flights matching your search.")
                        .font(.subheadline)
                } else {
                    ForEach(viewModel.searchResults) { searchResult in
                        ResultRow(mapPins: self.viewModel.getMapPins(for: searchResult), connection: searchResult)
                    }
                }
            }
        }
        .padding()
    }
}

struct ResultsHeader: View {
    
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
                Text("Flights | TUI fly")
                    .foregroundColor(Color.white)
                Spacer()
            }
        }
        .modifier(HeaderModifier(height: 60))
    }
}

struct ResultRow: View {

    @State var mapPins: [MapPin]?
    var connection: Connection
    
    var body: some View {
        
        VStack(spacing: 20) {
            HStack {
                Text(connection.from)
                    .font(.title)
                Spacer()
                Image(systemName: "arrow.right")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .aspectRatio(contentMode: .fit)
                Spacer()
                Text(connection.to)
                    .font(.title)
            }
            HStack {
                Text("Price:")
                    .font(.subheadline)
                Text(connection.price.currencyFormatted())
                    .font(.headline)
            }
            MapView(mapPins: $mapPins)
                .frame(height: 200)
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(viewModel: ResultsViewModel(searchInput: SearchInput(), connections: [Connection]()))
    }
}
