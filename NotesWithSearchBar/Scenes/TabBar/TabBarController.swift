//
//  TabBarController.swift
//  NotesWithSearchBar
//
//  Created by technomix on 18.01.23.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
}
extension TabBarController : UITabBarControllerDelegate{
}
