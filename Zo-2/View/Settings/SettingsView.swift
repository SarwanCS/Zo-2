//
//  SettingsView.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    @Environment(\.colorScheme) var scheme
    @Environment(\.openURL) var openURL
    
    @State private var isLog = false
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    @State private var isShowingMailView = false
    
    //private var email = SupportEmail(toAddress: "ajpicard25@icloud.com", subject: "ZoZo App Support")
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    HStack{
                        Image("CreateSnipBubble")
                        Spacer()
                    }
                    Spacer()
                }
                VStack{
                    Spacer()
                    VStack{
                        //CustomButton(text: "Edit Account", isLogout: false, isDarkModeToggle: false)
                        Button {
                            if scheme == .light {
                                changeDarkMode(state: true)
                            }else{
                                changeDarkMode(state: false)
                            }
                        } label: {
                            if scheme == .light {
                                CustomButton(text: "Toggle Dark Mode", isLogout: false, isDarkModeToggle: true)
                            } else {
                                CustomButton(text: "Toggle Light Mode", isLogout: false, isDarkModeToggle: true)
                            }
                        }

                    }
                    Spacer()
                    VStack{
                        //Button {
                            //Link("Terms & Agreements",destination: URL(string: "https://app.termly.io/document/terms-of-use-for-online-marketplace/b5002e65-2c63-4367-ac78-49f355bf22f7")!)
                            
                        //} label: {
                            //CustomButton(text: "Terms & Agreements", isLogout: false, isDarkModeToggle: false)
                        //}
                        
                        Button(action: {

                            if let yourURL = URL(string: "https://app.termly.io/document/terms-of-use-for-online-marketplace/b5002e65-2c63-4367-ac78-49f355bf22f7") {
                                UIApplication.shared.open(yourURL, options: [:], completionHandler: nil)
                            }

                        }, label: {
                           //Text("Privacy Policy")
                            CustomButton(text: "Terms & Agreements", isLogout: false, isDarkModeToggle: false)
                        })
                        
                        /*Button {
                            
                        } label: {
                            CustomButton(text: "Privacy Policy", isLogout: false, isDarkModeToggle: false)
                        }*/
                        
                        //LinkButton(text: "Privacy Policy", isLogout: false, isDarkModeToggle: false)
                        
                        Button(action: {

                            if let yourURL = URL(string: "https://app.termly.io/document/privacy-policy/84fda466-df65-4c0d-96c3-5400d19bc050") {
                                UIApplication.shared.open(yourURL, options: [:], completionHandler: nil)
                            }

                        }, label: {
                           //Text("Privacy Policy")
                            CustomButton(text: "Privacy Policy", isLogout: false, isDarkModeToggle: false)
                        })
                    }
                    Spacer()
                    VStack{
                        Button(action: {
                            if MFMailComposeViewController.canSendMail() {
                                self.isShowingMailView.toggle()
                            } else {
                                print("Can't send emails from this device")
                            }
                            if result != nil {
                                print("Result: \(String(describing: result))")
                            }
                        }, label: {
                            CustomButton(text: "Contact Us", isLogout: false, isDarkModeToggle: false)
                        })
                        
                        .sheet(isPresented: $isShowingMailView) {
                                    MailView(result: $result) { composer in
                                        composer.setSubject("ZoZo App Support")
                                        composer.setToRecipients(["ajpicard25@icloud.com"])
                                    }
                                }
                        
                        
                        
                        CustomButton(text: "Logout", isLogout: true, isDarkModeToggle: false)
                        
                        
                        
                    }
                    Spacer()
                }.padding(.top, 100)
            }.navigationTitle("Settings")
            .ignoresSafeArea()
            
        }
    }
    func changeDarkMode(state: Bool){
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ?   .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
}


struct CustomButton: View {
    let text: String
    let isLogout: Bool
    let isDarkModeToggle: Bool
    
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(isLogout ? Color("CustomRed") : scheme == .dark ? Color(.gray) : Color(.white))
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3)
                .fill(scheme == .dark ? .white : .black)
                
            HStack{
                if isDarkModeToggle{
                    Image(systemName: "moon.circle.fill")
                }
                Text(text)
                    .bold()
            }.foregroundColor(isLogout ? .white : scheme == .dark ? Color(.white) : Color(.black))
        }.frame(height: 60)
        .padding(.horizontal, 30)
            .padding(.bottom, 5)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct LinkButton: View {
    let text: String
    let isLogout: Bool
    let isDarkModeToggle: Bool
    
    @Environment(\.colorScheme) var scheme
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3)
                .fill(scheme == .dark ? .white : .black)
                
            HStack{
                if isDarkModeToggle{
                    Image(systemName: "moon.circle.fill")
                }
                Button("Visit Apple") {
                    openURL(URL(string: "https://www.apple.com")!)
                }
                //Text(text)
                    //.bold()
            }.foregroundColor(isLogout ? .white : scheme == .dark ? Color(.white) : Color(.black))
        }.frame(height: 60)
        .padding(.horizontal, 30)
            .padding(.bottom, 5)
    }
}

/*struct SupportEmail {
    let toAddress: String
    let subject: String
    
    func send(openURL: OpenURLAction) {
        let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        guard let url = URL(string: urlString) else { return }
    }
}*/



