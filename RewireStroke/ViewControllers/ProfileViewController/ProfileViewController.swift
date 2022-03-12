//
//  ProfileViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 17/06/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true

        // Need the below code to change bar title colour when using large titles – why?
        let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = Colours.primaryLowerLimb
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.rajdhaniSemiBold(size: 30), NSAttributedString.Key.foregroundColor: Colours.primaryDark]
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
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
