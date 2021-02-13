//
//  MessageViewController.swift
//  Interface
//
//  Created by erick.lozano.borges on 12/02/21.
//

import UIKit

class MessageViewController: UIViewController {
    
    // MARK: - Views
    let messageView = MessageView()
    
    // MARK: - Life Cycle
    init(title: String, message: String) {
        super.init(nibName: nil, bundle: nil)
        messageView.title = title
        messageView.message = message
    }
    
    init(image: UIImage? = nil, title: String, message: String? = nil, buttonConfiguration: MessageView.ButtonConfiguration) {
        super.init(nibName: nil, bundle: nil)
        messageView.image = image
        messageView.title = title
        messageView.message = message
        messageView.buttonConfiguration = buttonConfiguration
    }
    
    init(image: UIImage? = nil, title: String, message: String? = nil, shouldShowLoading: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        messageView.image = image
        messageView.title = title
        messageView.message = message
        messageView.shouldShowLoading = shouldShowLoading
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = messageView
    }
}
