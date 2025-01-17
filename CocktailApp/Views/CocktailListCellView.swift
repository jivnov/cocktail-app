//
//  CocktailListCellView.swift
//  CocktailApp
//
//  Created by Andrei Zhyunou on 01/12/2024.
//

import SwiftUI

struct CocktailListCellView: View {
    let cocktail: Cocktail
    
    var body: some View {
        HStack {
            if !cocktail.imageUrl.isEmpty {
                AsyncImage(url: URL(string: cocktail.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    default:
                        getEmptyProfileImage
                    }
                }
            } else {
                getEmptyProfileImage
            }
            
            Text(cocktail.name)
                .font(.headline)
        }
    }
    
    private var getEmptyProfileImage: some View {
        return Image(systemName: "wineglass")
            .resizable()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
    }
}

#Preview {
    CocktailListCellView(cocktail: Cocktail.MOCK_COCKTAIL)
}
