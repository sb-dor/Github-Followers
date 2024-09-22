//
//  SearchVC.swift
//  testapp
//
//  Created by Avaz on 22/09/24.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView      = UIImageView()
    let userNameTextField   = GFTextField()
    let callActionButton    = GFButton(background: .systemGreen, title: "Gett followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // if theme if dark it will be dark, if white will be white
        // Do any additional setup after loading the view.
        configureLogoImageView()
        configureTextField()
        configureButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // will remove title in appbar
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func configureTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // to the trailing and bottomAnchor set negative value
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureButton() {
        view.addSubview(callActionButton)
        callActionButton.translatesAutoresizingMaskIntoConstraints = false
        
        // to the trailing and bottomAnchor set negative value
        NSLayoutConstraint.activate([
            callActionButton.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: -50),
            
            callActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
