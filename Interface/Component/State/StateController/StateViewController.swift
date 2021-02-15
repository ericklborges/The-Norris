//
//  StateViewController.swift
//  Interface
//
//  Created by erick.lozano.borges on 13/02/21.
//

import UIKit

open class StateViewController: UIViewController {
    
    public enum State: Equatable {
        case main
        case loading(title: String, message: String?)
        case empty(title: String, message: String?, buttonConfiguration: ButtonConfiguration?)
        case error(image: UIImage?, title: String, message: String?, buttonConfiguration: ButtonConfiguration)
        
        public static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.main, .main):
                return true
            case (.loading, .loading):
                return true
            case (.empty, .empty):
                return true
            case (.error, .error):
                return true
            default:
                return false
            }
        }
    }
    
    public var state: State = .main {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.updatePresentation(to: self.state)
            }
        }
    }
}

// MARK: - Presentation State

extension StateViewController {

    private func updatePresentation(to state: State) {
        switch state {
        case .main:
            setupMain()
        case let .loading(title, message):
            setupLoading(title, message)
        case let .empty(title, message, buttonConfiguration):
            setupEmpty(title, message, buttonConfiguration)
        case let .error(image, title, message, buttonConfiguration):
            setupError(image, title, message, buttonConfiguration)
        }
    }
    
    func setupMain() {
        guard let currentChild = children.last else { return }
        remove(child: currentChild)
    }

    func setupLoading(_ title: String, _ message: String?) {
        let controller = MessageViewController(image: nil, title: title, message: message, shouldShowLoading: true)
        switchChild(to: controller)
    }

    func setupEmpty(_ title: String, _ message: String?, _ buttonConfiguration: ButtonConfiguration?) {
        let image = Symbol.pencilSlash.image(pointSize: 48)
        let controller = MessageViewController(image: image, title: title, message: message, buttonConfiguration: buttonConfiguration)
        switchChild(to: controller)
    }

    func setupError(_ image: UIImage?, _ title: String, _ message: String?, _ buttonConfiguration: ButtonConfiguration) {
        let controller = MessageViewController(image: image, title: title, message: message, buttonConfiguration: buttonConfiguration)
        switchChild(to: controller)
    }
}
