//
//  RegisterController.swift
//  TwitterClone
//
//  Created by made reihan on 23/03/24.
//

import Firebase
import FirebaseDatabase
import UIKit

class RegisterController: UIViewController {
    // MARK: - PROPERTIES

    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?

    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()

    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton(firstPart: "Already have an account? ", secondPart: "Sign In")
        button.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        return button
    }()

    private lazy var emailContainerView: UIView = {
        let imageView = #imageLiteral(resourceName: "mail")
        let view = Utilities().inputContainerView(withImage: imageView, textField: emailTextField)

        return view
    }()

    private lazy var passwordContainerView: UIView = {
        let imageView = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: imageView, textField: passwordTextField)

        return view
    }()

    private lazy var fullNameContainerView: UIView = {
        let imageView = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: imageView, textField: fullNameTextField)

        return view
    }()

    private lazy var usernameContainerView: UIView = {
        let imageView = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: imageView, textField: userNameTextField)

        return view
    }()

    private let emailTextField: UITextField = {
        Utilities().textField(withPlaceholder: "Email")
    }()

    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()

    private let fullNameTextField: UITextField = {
        Utilities().textField(withPlaceholder: "Full Name")
    }()

    private let userNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Username")
        return tf
    }()

    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
    }

    // MARK: - SELECTOR

    @objc func handleShowSignIn() {
        navigationController?.popViewController(animated: true)
    }

    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func handleRegister() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullNameTextField.text else { return }
        guard let username = userNameTextField.text?.lowercased() else { return }
        guard let profileImage = profileImage else {
            print("debug select profile image first")
            return
        }
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        
        AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
            guard let tab = window.rootViewController as? MainTabController else{return}
            
            tab.authenticationUserAndConfigureUI()
            
            self.dismiss(animated: true,completion: nil)
        }
    }

    // MARK: - HELPERS

    func configureUi() {
        view.backgroundColor = .twitterBlue

        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 128, height: 128)

        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullNameContainerView, usernameContainerView, registerButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually

        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)

        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingBottom: 16, paddingRight: 40)
    }
}

extension RegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage

        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3

        plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)

        dismiss(animated: true, completion: nil)
    }
}
