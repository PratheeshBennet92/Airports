//
//  ViewController.swift
//  Find Airport
//
//  Created by 1722885 on 28/11/19.
//  Copyright © 2019 tcs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var airportsVC: AirportListViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        airportsVC = AirportListViewController(nibName: airportListViewController, bundle: nil)
        let navigationController = UINavigationController(rootViewController: airportsVC)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }


}

