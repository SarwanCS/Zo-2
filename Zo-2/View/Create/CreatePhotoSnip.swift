//
//  CreatePhotoSnip.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import SwiftUI

struct CreatePhotoSnip: View {
    
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var scheme
    
    @State var text = ""
    
    @State var data = Data()
    @State var showImagePicker: Bool = false
    
    // Added by Michael, controls for showing Home Screen after
    // shortcut creation
    @State var showHomeView = false
 
    @EnvironmentObject var dataController: DataController
    @FetchRequest(sortDescriptors: []) var snips: FetchedResults<Snip>
    @Environment(\.managedObjectContext) var moc
    
    @State var defaultsSnip: [Sniptest] = []
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("PhotoSnipBubble")
                    Spacer()
                }
                Spacer()
            }
            
            VStack{
                Spacer()
                Button {
                   showImagePicker = true
                } label: {
                    CustomCreateButton(text: "Upload Photo", borderColor: scheme == .dark ? Color("CustomDarkGrey") : Color("CustomGray") , contentColor: scheme == .dark ? Color("CustomDarkGrey") : Color("CustomGray"))
                }.padding(.bottom, 5)

                CustomTextField(text: $text)
                Spacer()
                
                
                Button {
                    let coreDataSnip = Snip(context: moc)
                    
                    coreDataSnip.name = text
                    coreDataSnip.color = "ImageSnipColor"
                    coreDataSnip.image = "photo"
                    coreDataSnip.content = ""
                    coreDataSnip.pickedimage = data
                    
                    try? moc.save()
                    
                    updateDefaults()
                    
                    mode.wrappedValue.dismiss()
                    // Added by Michael, sets boolean to true
                    // To trigger return to Home
                    showHomeView = true
                } label: {
                    CustomCreateButton(text: "CREATE SHORTCUT", borderColor: scheme == .dark ? Color("CustomDarkGrey") : .black , contentColor: scheme == .dark ?  Color("CustomDarkGrey") : .white)
                }.padding(.bottom, 50)

            }.padding(.bottom, 50)
            
            
        }.sheet(isPresented: $showImagePicker) {
            ImagePickerView(sourceType: .photoLibrary) { image in
                data = image.jpegData(compressionQuality: 1.0) ?? Data()
            }
        }
        .overlay(
            HStack{
                Text("Photo Shortcut")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                Spacer()
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image("cancelButton")
                }.padding(.trailing, 40)
            }
                .padding(.top, 80)
            , alignment: .topTrailing
        ).navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        // Added by Michael, for returning to HomeView
        .fullScreenCover(isPresented: $showHomeView, content: {HomeView()})
    }
    func updateDefaults() {
        let snip = Sniptest(name: text, content: "", color: "ImageSnipColor", image: "photo", picked: data)

        if let savedSnips = shareDefault.object(forKey: "snip") as? Data {
            let decoder = JSONDecoder()
            if let loadedSnip = try? decoder.decode([Sniptest].self, from: savedSnips) {
                for i in loadedSnip {
                    defaultsSnip.append(i)
                }
                defaultsSnip.append(snip)
            }
        }

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(defaultsSnip) {
            shareDefault.set(encoded, forKey: "snip")
        }
    }
}

struct CreatePhotoSnip_Previews: PreviewProvider {
    static var previews: some View {
        CreatePhotoSnip()
    }
}
