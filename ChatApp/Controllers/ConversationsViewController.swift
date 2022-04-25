//
//  ViewController.swift
//  ChatApp
//
//  Created by user217567 on 4/25/22.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {  //controllerul principal, "radacina"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
    }
    
    private func validateAuth () {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
    }
    }
    


}


