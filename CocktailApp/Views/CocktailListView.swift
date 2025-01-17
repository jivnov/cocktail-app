//
//  CocktailListView.swift
//  CocktailApp
//
//  Created by Andrei Zhyunou on 01/12/2024.
//

import SwiftUI

struct CocktailListView: View {
    @StateObject var viewModel: CocktailListViewModel = CocktailListViewModel()
    
    @State private var showErrorPopup: Bool = false
    @State private var currentErrorDescription: String = ""
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.cocktails.isEmpty {
                    Text("No cocktails :(")
                        .font(.headline)
                        .foregroundColor(.gray)
                } else {
                    List(viewModel.cocktails) { cocktail in
                        CocktailListCellView(cocktail: cocktail)
                    }
                }
            }
            .navigationTitle("Cocktails")
            .onReceive(viewModel.$error) { error in
                if let error = error {
                    currentErrorDescription = error
                    showErrorPopup = true
                }
            }
            .alert(isPresented: $showErrorPopup) {
                Alert(
                    title: Text("Error"),
                    message: Text(currentErrorDescription),
                    dismissButton: .default(Text("OK"), action: {
                        showErrorPopup = false
                        viewModel.resetError()
                    })
                )
            }
        }
    }
}

#Preview {
    CocktailListView(viewModel: CocktailListViewModel())
}
