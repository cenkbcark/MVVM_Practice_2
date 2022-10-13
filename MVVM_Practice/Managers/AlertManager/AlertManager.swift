//
//  AlertManager.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 13.10.2022.
//

import Foundation
import UIKit

// MARK: - AlertShowable
protocol AlertShowable {
    func showAlert(with error: ApiError)
}

// MARK: - AlertManager
final class AlertManager: AlertShowable {
    
    // MARK: Properties
    static let shared: AlertManager = .init()
    
    func showAlert(with error: ApiError) {

        let alert = UIAlertController(
            title: "Opps!",
            message: error.description,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            
        }))

        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true)
        }
    }
}
