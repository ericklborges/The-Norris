//
//  SplashScreenViewController.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 15/02/21.
//

import UIKit
import Interface

protocol SplashScreenFlowDelegate: AnyObject {
    func splashScreenDidFinishSetup(_ controller: SplashScreenViewController)
}

final class SplashScreenViewController: UIViewController {
    
    // MARK: - Views
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // MARK: - Properties
    private let viewModel: SplashScreenViewModel
    weak var flowDelegate: SplashScreenFlowDelegate?
    
    // MARK: - Life Cycle
    init(viewModel: SplashScreenViewModel = SplashScreenViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLaunchScreen()
        addActivityIndicator()
        viewModel.fetchCategoriesIfNeeded()
    }
    
    // MARK: - Setup
    private func addLaunchScreen() {
        guard let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: Bundle.main).instantiateInitialViewController() else {
            preconditionFailure("LaunchScreen is not configured correctly.")
        }
        install(child: launchScreen)
    }
    
    private func addActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.layout.applyConstraint { make in
            make.centerXAnchor(equalTo: view.centerXAnchor)
            make.bottomAnchor(equalTo: view.bottomAnchor, constant: -160)
        }
    }
}

// MARK: - SplashScreenViewModelDelegate

extension SplashScreenViewController: SplashScreenViewModelDelegate {
    func didFinishSetup() {
        flowDelegate?.splashScreenDidFinishSetup(self)
    }
}
