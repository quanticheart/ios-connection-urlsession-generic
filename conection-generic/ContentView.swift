//
//  ContentView.swift
//  conection-generic
//
//  Created by Jonn Alves on 11/03/23.
//

import SwiftUI

struct ContentView: View {
    
    let conn1 = ContentViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear{
            conn1.feetList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
