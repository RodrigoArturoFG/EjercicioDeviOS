//
//  TestView.swift
//  MyAppCDMX
//
//  Created by Fernández González Rodrigo Arturo on 07/08/24.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        NavigationStack {
            Text("Prueba de UI")
            .navigationTitle("1,234.00")
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
