//
//  SFSafariViewController.swift
//  ScienceResearchApp
//
//  Created by Yuiko Suzuki on 8/13/21.
//

import UIKit
import SafariServices

class SFSafariViewController: UIViewController, SFSafariViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        func showTutorial(_ which: Int) {
            if let url = URL(string: "https://www.google.com") {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                
                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTutorial(indexPath.row)
    }
}
