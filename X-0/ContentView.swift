//
//  ContentView.swift
//  X-0
//
//  Created by Tibor Waxmann on 24/10/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
        Home()
            .navigationTitle("X - 0")
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
