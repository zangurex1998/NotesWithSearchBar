//
//  HomeViewController.swift
//  NotesWithSearchBar
//
//  Created by technomix on 18.01.23.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - Outlets

    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
      
    }
    //MARK: - Actions
    @IBAction func didTapSubmit(_ sender: Any) {
            setUpNotification()
    }
    
    //MARK: - Methods
    private func setUpView(){
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Enter name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    private func setUpNotification(){
        NotificationCenter.default.post(name: .name, object: nil, userInfo: ["username" : nameTextField.text ?? ""])
    }
    
}
extension Notification.Name{
    static let name = NSNotification.Name("userName")
}

