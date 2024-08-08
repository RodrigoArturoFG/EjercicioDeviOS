//
//  ListView.swift
//  MyAppCDMX
//
//  Created by Fernández González Rodrigo Arturo on 07/08/24.
//

import SwiftUI

struct ListView: View {
    @StateObject private var listViewModel = ListViewModel(apiClient: APIClient())
    //@State private var users = []
    
    var body: some View {
        NavigationStack {
            if var users = listViewModel.data {
                List{
                    ForEach(users, id: \.id) { user in
                        HStack{
                            if user.favorite! {
                                Text("⭐️")
                            }
                            Text(user.firstName)
                        }
                        .swipeActions(edge: .trailing){
                            Button{
                                listViewModel.updateFavoriteUser(withId: user.id)
                            } label : {
                                Label("Favorito", systemImage: "star.fill")
                            }
                        }
                        .tint(.blue)
                        .swipeActions(edge: .leading){
                            Button{
                                listViewModel.removeUser(withId: user.id)
                            } label : {
                                Label("Borrar", systemImage: "trash.fill")
                            }
                        }
                        .tint(.red)
                    }
                }.listStyle(PlainListStyle())
            } else if let error = listViewModel.error {
                Text(error.localizedDescription)
                    .font(.largeTitle)
            }
            else {
                ProgressView("Cargandos datos…")
                //SpinnerView(tintColor: .blue, scaleSize: 2.0)
            }
        }
        .task {
            listViewModel.fetchUsers()
        }
        .navigationTitle("Lista")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

struct SpinnerView: View {
    //default values
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 2.0
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
            .scaleEffect(scaleSize, anchor: .center)
    }
}
