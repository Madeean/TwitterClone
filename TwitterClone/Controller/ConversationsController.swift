//
//  ConversationsController.swift
//  TwitterClone
//
//  Created by made reihan on 23/03/24.
//

import UIKit

class ConversationsController: UIViewController{
    // MARK: - PROPERTIES
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - HELPERS
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Conversations"
    }
}

