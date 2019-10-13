//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Max Nabokow on 10/12/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            if let attachments = item.attachments {
                for attachment: NSItemProvider in attachments {
                    if attachment.hasItemConformingToTypeIdentifier("public.url") {
                        attachment.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) in
                            if let shareURL = url as? URL {
                                
                                print(UserDefaults(suiteName: "group.mnabokow.trustme")?.object(forKey: "recentURL"))
                               
                                do {
                                UserDefaults.init(suiteName: "group.mnabokow.trustme")?.set(try String(contentsOf: shareURL), forKey: "recentURL")
                                } catch {}
                                
                                print(UserDefaults(suiteName: "group.mnabokow.trustme")?.object(forKey: "recentURL"))
                            }
                            self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
                        })
                    }
                }
            }
        }
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
