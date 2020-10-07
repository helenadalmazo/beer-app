//
//  AboutTableViewController.swift
//  beer-app
//
//  Created by Helena Dalmazo on 07/10/20.
//  Copyright © 2020 Helena Dalmazo. All rights reserved.
//

import MessageUI
import UIKit

class AboutTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var authorImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authorImage.layer.cornerRadius = self.authorImage.frame.size.width / 2
        
        getAuthorImage()
    }
    
    func getAuthorImage() {
        let imageUrlString = "https://avatars2.githubusercontent.com/u/22308459?s=400&u=06982dc3027d88b42f1779b7a40456ab0577c6d7&v=4"
        if let imageUrl = URL(string: imageUrlString) {
            do {
                let bytes = try Data(contentsOf: imageUrl)
                
                let image = UIImage(data: bytes)
                
                self.authorImage.image = image
            } catch {
                print("[ERROR] Getting author image: \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard var text = tableView.cellForRow(at: indexPath)?.detailTextLabel?.text else {
            return
        }
        
        if text.contains("http") {
            openUrl(text)
        }
        
        if text.contains("@gmail.com") {
            openMailTo(text)
        }
    }
    
    private func openUrl(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        if !UIApplication.shared.canOpenURL(url) {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func openMailTo(_ emailTo: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([emailTo])
            
            present(mail, animated: true)
        } else {
            openUrl("mailto:\(emailTo)")
        }
    }
}
