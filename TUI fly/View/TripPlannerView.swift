//
//  ContentView.swift
//  TUI fly
//
//  Created by Aaron Taylor on 09/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import SwiftUI

struct TripPlannerView: View {
    
    @ObservedObject var viewModel: TripPlannerViewModel
    @ObservedObject var searchInput = SearchInput()
    
    var body: some View {
        
        VStack(spacing: 10) {
            VStack(spacing: 0) {
                TripFromItem(searchInput: searchInput)
                Divider().foregroundColor(Color.gray)
                TripToItem(searchInput: searchInput)
            }
            DateStubView()
            PassengersStubView()
            Spacer().frame(height: 10)
            TripPlannerButtons(viewModel: viewModel, searchInput: searchInput)
        }
        .background(EmptyView().sheet(isPresented: $searchInput.showResultsView) {
            ResultsView(viewModel: ResultsViewModel(searchInput: self.searchInput, connections: self.viewModel.connections))
        })
        .background(EmptyView().sheet(isPresented: $searchInput.showSearchView) {
            SearchView(viewModel: SearchViewModel(connections: self.viewModel.connections), searchInput: self.searchInput)
        })
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(viewModel.errorMessage))
        })
        .padding()
    }
}

struct TripPlannerButtons: View {
    
    @ObservedObject var viewModel: TripPlannerViewModel
    @ObservedObject var searchInput: SearchInput
    
    var body: some View {
        
        VStack(spacing: 10) {
            CustomButton(text: "SEARCH", action: {
                self.searchInput.showResultsView = true
            }, backgroundColor: viewModel.isSearchDisabled(searchInput: searchInput) ? Color.gray : Color.tuiDarkBlue)
            .disabled(viewModel.isSearchDisabled(searchInput: searchInput) ? true : false)
            CustomButton(text: "Reset all", action: {
                self.resetSearchInput()
            }, textColor: viewModel.isSearchDisabled(searchInput: searchInput) ? Color.tuiLightBlue : Color.white, backgroundColor: Color.tuiLightBlue)
            .disabled(viewModel.isSearchDisabled(searchInput: searchInput) ? true : false)
        }
    }
    
    func resetSearchInput() {
        self.searchInput.selectedDirection = .from
        self.searchInput.fromDestination = ""
        self.searchInput.toDestination = ""
    }
}



struct TripFromItem: View {
    
    @ObservedObject var searchInput: SearchInput
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "airplane")
                .foregroundColor(Color.tuiDarkBlue)
            VStack(alignment: .leading, spacing: 5) {
                Text("Flying from")
                    .foregroundColor(Color.tuiDarkBlue)
                    .fontWeight(.semibold)
                if searchInput.fromDestination.isEmpty {
                    Text("Select departure airport")
                        .foregroundColor(searchInput.fromDestination.isEmpty ? Color.gray : nil)
                } else {
                    Text(searchInput.fromDestination)
                }
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.searchInput.selectedDirection = Direction.from
            self.searchInput.showSearchView = true
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct TripToItem: View {
    
    @ObservedObject var searchInput: SearchInput

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "airplane")
                .foregroundColor(Color.tuiDarkBlue)
            VStack(alignment: .leading, spacing: 5) {
                Text("Flying to")
                    .foregroundColor(Color.tuiDarkBlue)
                    .fontWeight(.semibold)
                if searchInput.toDestination.isEmpty {
                    Text("Select destination airport")
                        .foregroundColor(searchInput.toDestination.isEmpty ? Color.gray : nil)
                } else {
                    Text(searchInput.toDestination)
                }
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.searchInput.selectedDirection = Direction.to
            self.searchInput.showSearchView = true
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct DateStubView: View {
    
    var body: some View {
        
        HStack(spacing: 10) {
            Image(systemName: "calendar")
                .foregroundColor(Color.tuiDarkBlue)
            VStack(alignment: .leading, spacing: 5) {
                Text("Dates")
                    .foregroundColor(Color.tuiDarkBlue)
                    .fontWeight(.semibold)
                Text("Departure date - Return date")
                    .foregroundColor(Color.gray)
            }
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct PassengersStubView: View {
    
    var body: some View {
        
        HStack(spacing: 10) {
            Image(systemName: "person.2.fill")
                .foregroundColor(Color.tuiDarkBlue)
            VStack(alignment: .leading, spacing: 5) {
                Text("Passengers")
                    .foregroundColor(Color.tuiDarkBlue)
                    .fontWeight(.semibold)
                Text("2 Adults")
            }
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TripPlannerView(viewModel: TripPlannerViewModel())
    }
}
