//
//  ChatTextInputView.swift
//  Chat
//
//  Created by ktrkathir on 11/02/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import UIKit

/// Messenger constant

/// Container view height
///
/// - minimum: Minimum height = 50.0
/// - maximum: Maximum height = 150.0
enum ContainerViewHeight: CGFloat {
    case minimum = 100.0
    case maximum = 150.0
}

struct MessengerConstant {
    
    /// Sender id
    static let senderID = "1"
    
    /// Receiver id
    static let receiverID = "2"
    
    /// Place holder
    static let textViewPlaceHodler = "Write a message"
    
    /// Pattern image
    static let bgPatternImage: UIImage = UIImage(named: "ChatBgPattern")!
    
    /// Maximum number of character in textView
    static let maximumCharCount: Int = 250
}

/// Chat text input view
class ChatTextInputView: UITextView {
    
    convenience init() {
        
        let layoutManager = NSLayoutManager()
        
        let textStorage = NSTextStorage()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: .zero)
        layoutManager.addTextContainer(textContainer)
        
        self.init(frame: .zero, textContainer: textContainer)
        contentInset = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)        
        self.setup()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setPlaceHolder() {
        if self.text == "" {
            self.text = MessengerConstant.textViewPlaceHodler
            self.textColor = UIColor.lightGray
            self.enablesReturnKeyAutomatically = true
            self.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(16.0))
        }
    }
    
    fileprivate func setup() {
        self.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(16.0))
        
        self.text = MessengerConstant.textViewPlaceHodler
        self.textColor = UIColor.lightGray
        self.enablesReturnKeyAutomatically = false
        self.addShadow()
        
        // backgroundColor = UIColor.white
        self.isEditable = true
        self.isSelectable = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(notified(notification:)), name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notified(notification:)), name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    @objc func notified(notification: Notification) {
        
        if notification.name == UITextView.textDidBeginEditingNotification {
            contentInset = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
            
            if self.text == MessengerConstant.textViewPlaceHodler {
                self.text = ""
                self.textColor = .darkText
                self.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(16.0))
            }
        } else if notification.name == UITextView.textDidEndEditingNotification {
            if self.text.isEmpty {
                setPlaceHolder()
            }
        }
    }
}
