//
//  ContentView.swift
//  MyAppCDMX
//
//  Created by Fernández González Rodrigo Arturo on 07/08/24.
//

import SwiftUI

struct HomeView: View {
    // Tab Seleccionada por Default al abrir la aplicación
    @State private var selectedTab: Int = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            NavigationStack() {
                ListView()
            }
            .tabItem {
                Image(systemName: "list.number")
                Text("Web API")
            }.tag(1)
            
            
            NavigationStack() {
                MapView()
            }
            .tabItem {
                Image(systemName: "mappin.and.ellipse")
                Text("Mapa")
            }.tag(2)
            
            NavigationStack() {
                TestView()
            }
            .tabItem {
                Image(systemName: "doc.text.image")
                Text("Test UI")
            }.tag(3)
        }
            
            
//            Image("Profile")
//              .resizable()
//              .aspectRatio(contentMode: .fit)
//              .frame(width: 200, height: 200)
//              .clipShape(Circle())
//              .overlay(Circle().stroke(Color.white, lineWidth: 4))
//              .shadow(radius: 7)
            
//            Rectangle()
//              .fill(selectedColor)
//              .frame(width: 100, height: 100, alignment: .center)
//
//            ColorPickerView(selectedColor: $selectedColor)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

