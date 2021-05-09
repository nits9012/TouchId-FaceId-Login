//
//  ContentView.swift
//  TouchIdAndFaceIdLogin
//
//  Created by Nitin Bhatt on 4/17/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var abc = "test"
    
    var body: some View {
        ZStack{
            Color("AppTheme").edgesIgnoringSafeArea(.all)
            VStack{
                Text("Successfully Login").foregroundColor(.white).font(.system(size: 16, weight:.light))
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
