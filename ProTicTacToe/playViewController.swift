//
//  playViewController.swift
//  ProTicTacToe
//
//  Created by Leonard Follner on 22.09.16.
//  Copyright © 2016 Alex Jenke. All rights reserved.
//

import Foundation
import UIKit

class playViewController: UIViewController {

    @IBAction func button(_ sender: UIButton) {
            performSegue(withIdentifier: "pttt3d", sender: self)
    }
}
