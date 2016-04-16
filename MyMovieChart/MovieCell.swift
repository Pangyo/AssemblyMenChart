//
//  MovieCell.swift
//  MyMovieChart
//
//  Created by KimHyo kook on 2016. 3. 23..
//  Copyright © 2016년 Hyokook KIM. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet var desc: UILabel!
    
    @IBOutlet var rating: UILabel!
    
    @IBOutlet var thumbnail: UIImageView!
    
    @IBOutlet var opendate: UILabel!
}