//
//  TouchIdAndFaceIdLoginView.swift
//  TouchIdAndFaceIdLogin
//
//  Created by Nitin Bhatt on 4/17/21.
//

import SwiftUI
import LocalAuthentication

extension LAContext{
    enum BiometricType:String{
        case none
        case touchID
        case faceID
    }
    
    var biometricType:BiometricType{
        var error:NSError?
        guard self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }
        
        switch self.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        default:
            return .none
        }
    }
}

struct TouchIdAndFaceIdLoginView: View {
    
    var biometricType = LAContext().biometricType
    
    @State private var isUnlocked = false
    
    var body: some View {
        
        ZStack{
            Color("AppTheme").edgesIgnoringSafeArea(.all)
            VStack{
                if self.biometricType == .faceID{
                    Image("faceId").resizable().frame(width: 80, height: 80).padding()
                    Text("Log in with Face ID").foregroundColor(.white).font(.system(size:25, weight: .bold)).padding(2)
                    Text("Please put your phone in front of your face to login.").foregroundColor(.white).font(.system(size: 16, weight:.light))
                }else{
                    Image("fingerPrint").resizable().frame(width: 80, height: 80).padding()
                    Text("Log in with Touch ID").foregroundColor(.white).font(.system(size:25, weight: .bold)).padding(2)
                    Text("Please put your finger on the home button to login.").foregroundColor(.white).font(.system(size: 16, weight:.light))
                }
            }.onAppear(perform:authenticate)

        }.fullScreenCover(isPresented: $isUnlocked, content: ContentView.init)
        
    }
    
    func authenticate(){
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We need to unlock your data."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authencationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    }
                }
            }
        }
        
    }
}

struct TouchIdAndFaceIdLoginView_Previews: PreviewProvider {
    static var previews: some View {
        TouchIdAndFaceIdLoginView()
    }
}
