//
//  MessagesViewController.swift
//  Khadamaaty
//
//  Created by Alisa Nekrasova on 20/12/2016.
//  Copyright © 2016 H2MStudio. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import SwiftHEXColors

class MessagesViewController: JSQMessagesViewController {
    
    
    var khaSpinner: KhaSpinner?
    
    func showKhaSpinner() {
        hideKhaSpinner()
        
        khaSpinner = KhaSpinner(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.view.addSubview(khaSpinner!)
    }
    
    func showKhaSpinner(title: String) {
        showKhaSpinner()
    }
    
    func hideKhaSpinner() {
        if let khaSpinner = khaSpinner {
            khaSpinner.removeFromSuperview()
        }
        khaSpinner = nil
    }
    
    class ProviderAvatar: NSObject, JSQMessageAvatarImageDataSource {
        
        var providerImage: UIImage?
        
        init(_ image: UIImage?) {
            super.init()
            
            providerImage = image
        }
        
        func avatarImage() -> UIImage! {
            return providerImage
        }
        
        func avatarHighlightedImage() -> UIImage! {
            return providerImage
        }
        
        func avatarPlaceholderImage() -> UIImage! {
            return nil
        }
    }
    
    var cameFromNotification = false
    var messages = [JSQMessage]()
    
    var projectId: Int?
    var providerName: String = NSLocalizedString("Provider", comment: "")
    var providerImage: UIImage?
    
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    
    var timer: Timer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Messages", comment: "")
        senderId = NSLocalizedString("me", comment: "")
        
        // 7/10/20.
        
      //  senderDisplayName = User.me.profile!.firstName
        
        setupBubbles()
        
        JSQMessagesToolbarButtonFactory.defaultSendButtonItem().setTitle("d", for: .normal)
        self.inputToolbar.contentView.leftBarButtonItem = nil
        
        let button = JSQMessagesToolbarButtonFactory.defaultSendButtonItem()
        button?.setTitle(NSLocalizedString("send", comment: ""), for: UIControl.State.normal)
        self.inputToolbar.contentView.rightBarButtonItem = button
        self.inputToolbar.contentView.textView.placeHolder = NSLocalizedString("New Message", comment: "")
        self.inputToolbar.contentView.textView.accessibilityLabel = NSLocalizedString("New Message", comment: "")
        self.collectionView.semanticContentAttribute = .forceLeftToRight
        collectionView!.backgroundColor = UIColor.clear
        topContentAdditionalInset = 64.0
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize(width: 38.0, height: 34.0)
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = .zero
   
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
        topView.backgroundColor = .white
        view.addSubview(topView)
        view.bringSubview(toFront: topView)
        
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 28, width: UIScreen.main.bounds.width, height: 30))
        lblTitle.textColor = UIColor.darkGray
        lblTitle.text = NSLocalizedString("Messages", comment: "")
        lblTitle.textAlignment = .center
        self.view.addSubview(lblTitle)
        
        
        let btnBack = UIButton()
//        if L102Language.currentAppleLanguage() == "ar" {
//            let screenWidth = UIScreen.main.bounds.width
//            btnBack.frame = CGRect(x: screenWidth - 38, y: 28, width: 30, height: 30)
//            btnBack.transform = CGAffineTransform(scaleX: -1, y: 1)
//        } else {
            btnBack.frame = CGRect(x: 8, y: 28, width: 30, height: 30)
      //  }
        btnBack.setImage(UIImage(named: "ic_back-1")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnBack.tintColor = UIColor(hexString: "#EB5769")
        btnBack.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.view.addSubview(btnBack)
        let tap = UITapGestureRecognizer(target: self, action: #selector(MessagesViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showKhaSpinner(title: NSLocalizedString("Loading messages...", comment: ""))
        loadMessages()
        
     //   NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive(app:)), name:UIApplication.NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
      //  timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.loadMessages), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
      //  timer?.invalidate()
    }
    
    @objc func appDidBecomeActive(app: UIApplication) {
        showKhaSpinner(title: NSLocalizedString("Loading messages...", comment: ""))
        
        loadMessages()
    }
    
    func loadMessages() {
        messages.removeAll()
        self.collectionView.reloadData()

      /*  APIClient.sharedInstance.messages(id: self.projectId ?? -1, delegate: { (meta, messages) in
            if meta.isSuccess() {
                for m in messages {
                    if m.sent {
                        self.addMessage(id: self.providerName, text: m.text)
                    }
                    else {
                        self.addMessage(id: self.senderId, text: m.text)
                    }
                }
            }
            self.hideKhaSpinner()
            self.finishReceivingMessage()
        }) */
        
//        APIClient.sharedInstance.provider(id: project?.providerId ?? -1) { (meta, provider) in
//            if meta.isSuccess(), provider != nil,
//                let url = URL(string: provider!.profileImage ?? "") {
//                self.providerName = provider!.name.get()
//                if let data = try? Data(contentsOf: url) {
//                    self.providerImage = UIImage(data: data)
//                }
//            }
//            
//            APIClient.sharedInstance.messages(id: self.project?.id ?? -1, delegate: { (meta, messages) in
//                if meta.isSuccess() {
//                    for m in messages {
//                        if m.sent {
//                            self.addMessage(id: self.providerName, text: m.text)
//                        }
//                        else {
//                            self.addMessage(id: self.senderId, text: m.text)
//                        }
//                    }
//                }
//                
//                self.hideKhaSpinner()
//                self.finishReceivingMessage()
//            })
//        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        if indexPath.item < messages.count {
            return messages[indexPath.item]
        } else {
            
            return nil
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    private func setupBubbles() {
        if let factory = JSQMessagesBubbleImageFactory() {
            incomingBubbleImageView = factory.incomingMessagesBubbleImage(
                with: UIColor.jsq_messageBubbleBlue())
            outgoingBubbleImageView = factory.outgoingMessagesBubbleImage(
                with: UIColor.jsq_messageBubbleLightGray())
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingBubbleImageView
        }
        else {
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return nil
        }
        else {
            return ProviderAvatar(providerImage)
        }
    }
    
    func addMessage(id: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: "", text: text) {
            messages.append(message)
        }
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        showKhaSpinner(title: NSLocalizedString("Sending...", comment: ""))
      /*  APIClient.sharedInstance.newMessage(id: projectId ?? -1, message: text) { (meta) in
            self.hideKhaSpinner()
            
            if meta.isSuccess() {
                self.inputToolbar.contentView.textView.text = ""
                self.addMessage(id: senderId, text: text)
                self.finishReceivingMessage()
            }
            else {
                self.dismissKeyboard()
                let errmsg = NSLocalizedString("Can't send a message", comment: "")
                _ = SweetAlert().showAlert(NSLocalizedString("Error", comment: ""), subTitle: errmsg, style: .error, buttonTitle: NSLocalizedString("Ok", comment: ""))
            }
        } */
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
            as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        if message.senderId != senderId {
            cell.textView!.textColor = UIColor.white
        } else {
            cell.textView!.textColor = UIColor.black
        }
        
        return cell
    }
    
    @IBAction func goBack(_ sender: Any) {
        if cameFromNotification {
            dismiss(animated: true, completion: nil)
        } else {
            if let nc = self.navigationController {
                nc.popViewController(animated: true)
            }
            else {
                dismiss(animated: true, completion: nil)
            }            
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
