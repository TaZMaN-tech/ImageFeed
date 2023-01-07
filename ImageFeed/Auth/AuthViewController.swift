//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Тадевос Курдоглян on 21.12.2022.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}

final class AuthViewController: UIViewController {
    
    private let ShowWebViewSegueIdentifier = "ShowWebView"
    private let authService = OAuth2Service()
    private let auth2TokenStorage = OAuth2TokenStorage()
    
    weak var delegate: AuthViewControllerDelegate?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowWebViewSegueIdentifier {
            guard
                let webViewViewController = segue.destination as? WebViewViewController
            else { fatalError("Failed to prepare for \(ShowWebViewSegueIdentifier)") }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        authService.fetchOAuthToken(code) { result in
            switch result {
            case .success(let token):
                DispatchQueue.main.async {
                    print(token)
                    self.auth2TokenStorage.token = token
                    self.delegate?.authViewController(self, didAuthenticateWithCode: code)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
            
        }
    }

    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
}
