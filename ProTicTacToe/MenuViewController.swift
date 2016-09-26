//
//  MenuVieController.swift
//  ProTicTacToe
//
//  Created by Leonard Follner on 22.09.16.
//  Copyright © 2016 Alex Jenke. All rights reserved.
//

import Foundation
import UIKit


class MenuViewController: UIViewController {
    
    @IBAction func scanButton (_ sender: UIButton!) {
        performSegue(withIdentifier: "play", sender: self)
        
    }
}
