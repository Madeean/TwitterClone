//
//  CaptionTextView.swift
//  TwitterClone
//
//  Created by made reihan on 27/03/24.
//

import UIKit

class CaptionTextView: UITextView {
    
    //MARK:-PROPERTIES
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "Whats happening"
        return label
    }()
    
    //MARK:-LIFECYCLE
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor,left: leftAnchor, paddingTop: 8, paddingLeft: 4) 
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTextInputChange(){
        placeholderLabel.isHidden = !text.isEmpty
    }
}
