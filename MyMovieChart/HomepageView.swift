//
//  HomepageView.swift
//  MyMovieChart
//
//  Created by KimHyo kook on 2016. 4. 12..
//  Copyright © 2016년 Hyokook KIM. All rights reserved.
//

import Foundation
import UIKit

class HomepageViewController: UIViewController {
    
    @IBOutlet var navibar: UINavigationItem!
    
    @IBOutlet var wv: UIWebView!
    
    //var assemblyVO : AssemblymanVO? = nil
    
    var Homepage = String()
    var name = String()
    
    override func viewDidLoad() {
        
        self.navibar.title = name
        let req = NSURLRequest(URL: NSURL(string: Homepage)!)
        self.wv.loadRequest(req)
    }
}
