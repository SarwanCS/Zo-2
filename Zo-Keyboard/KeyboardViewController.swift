//
//  KeyboardViewController.swift
//  Zo-Keyboard
//
//  Created by Brian Heralall on 3/4/22.
//

import UIKit
import SwiftUI
import UniformTypeIdentifiers
import MobileCoreServices

class KeyboardViewController: UIInputViewController {

    
    @IBOutlet var nextKeyboardButton: UIButton!
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        var snip: [Sniptest] = []
        
        if let savedSnips = shareDefault.object(forKey: "snip") as? Data {
            let decoder = JSONDecoder()
            if let loadedSnip = try? decoder.decode([Sniptest].self, from: savedSnips) {
                snip = loadedSnip.uniqued()
            }
        }
        
        let child = UIHostingController(rootView: KeyboardView(snip: snip, printOut: { content in
            self.textDocumentProxy.insertText(content)
        }))
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        child.view.backgroundColor = .clear
        view.addSubview(child.view)
        addChild(child)
        
        
        

    }
}


struct KeyboardView: View {
    
    @State private var document: MessageDocument = MessageDocument(message: "Hello, World!")
    @State private var isExporting: Bool = false
    
    var snip: [Sniptest]
    var printOut: (String) -> Void
    
    var body: some View {
        HStack{
            VStack{
                HStack{
                    Text("Your Zo Shortcuts")
                        .font(.system(size: 18, weight: .bold))
                    Spacer()
                }.padding()
                if snip.isEmpty {
                    Spacer()
                    Text("You don't have any shortcuts yet.")
                        .bold()
                    Spacer()
                }else{
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(alignment: .leading, spacing: 10){
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading) {
                                ForEach(snip, id: \.self){ snip in
                                    Button {
                                        if snip.image == "photo" {
                                            //UIPasteboard.general.setData(snip.pickedimage, forPasteboardType: UTType.png.identifier)
                                            //printOut("Executing") image
                                            let image = UIImage(data: snip.pickedimage)
                                            UIPasteboard.general.image = image;

                                        }else{
                                            printOut(snip.content)
                                        }
                                    } label: {
                                        HStack{
                                            Image(systemName: snip.image)
                                            Text(snip.name)
                                        }.padding()
                                        .foregroundColor(.white)
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color(snip.color))
                                                .frame(height: 50)
                                        )
                                    }
                                }
                            }

                        }.padding()
                    }
                }
                Spacer()
            }
            Spacer()
        }
    }
}


















/*import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}*/
