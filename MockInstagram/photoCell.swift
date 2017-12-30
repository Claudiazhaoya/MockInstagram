//
//  photoCell.swift
//  MockInstagram
//
//  Created by Zhaoya Sun on 12/27/17.
//  Copyright © 2017 Zhaoya Sun. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI

class photoCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    var post: Post! {
        didSet {
            self.postImage.file = post.media
            self.postImage.loadInBackground()
            self.usernameLabel.text = post.author.username
            self.captionLabel.text = post.caption
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}
