//
//  ChatterViewController.swift
//  My Chatter


import UIKit

class ChatterViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        
    }

    func setupNav () {
        self.navigationItem.title = "Message"
        self.navigationController?.navigationBar.barTintColor = UIColor.purple
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
