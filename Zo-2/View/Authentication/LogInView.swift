//
//  LogInView.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

/*

import SwiftUI
import AuthenticationServices

struct LogInView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var loggedIn: Bool
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    HStack{
                        Image("UpperBubble")
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Image("LowerBubble")
                    }
                    
                }
                VStack{
                    Spacer()
                    VStack(alignment: .leading){
                        Text("Welcome to ZoZo!")
                            .font(.system(size: 30, weight: .bold))
                            .padding(.bottom, 2)
                        Text("Create shortcuts for the pictures, text phrases, files & links you use the most and access them right from the ZoZo keyboard.")
                        HStack{
                            Spacer()
                            SignInWithAppleButton(
                                .signIn,
                                onRequest: configure,
                                onCompletion: handle
                            )
                                .signInWithAppleButtonStyle(
                                    colorScheme == .dark ? .white : .black
                                )
                                .frame(height: 45)
                            .padding()
                            .padding(.top, 30)
                            Spacer()
                        }
                    }.padding(30)
                        .padding(.bottom, 70)
                    Spacer()
                    /*HStack{
                        Text("Don't have an account?")
                        NavigationLink {
                            SignUpView(loggedIn: $loggedIn)
                        } label: {
                            Text("Sign Up Here.")
                                .underline()
                                .bold()
                        }.foregroundColor(scheme == .dark ? .white : .black)


                    }.padding(.bottom, 40)*/
                }
            }.overlay(alignment: .topLeading, content: {
                Logo()
                    .padding(40)
            })
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        
    }
    func configure(_ request: ASAuthorizationAppleIDRequest) {
            request.requestedScopes = [.fullName, .email]
        }
        
        func handle(_ authResult: Result<ASAuthorization, Error>) {
            switch authResult {
            case .success(let auth):
                loggedIn = true
                switch auth.credential {
                case let appleIdCredentials as ASAuthorizationAppleIDCredential:
                    if let appleUser = AppleUser(credentials: appleIdCredentials),
                       let appleUserData = try? JSONEncoder().encode(appleUser) {
                        UserDefaults.standard.setValue(appleUserData, forKey: appleUser.userId)
                        
                        print("saved apple user", appleUser)
                        
                    } else {
                        guard
                            let appleUserData = UserDefaults.standard.data(forKey: appleIdCredentials.user),
                            let appleUser = try? JSONDecoder().decode(AppleUser.self, from: appleUserData)
                        else { return }
                    }
                    
                default:
                    print(auth.credential)
                }
                
            case .failure(let error):
                print(error)
            }
        }
}

//struct LogInView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogInView()
//            .preferredColorScheme(.light)
//    }
//}

*/
