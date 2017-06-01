//
//  AudiobookTableViewCell.swift
//  AudiobookClub
//
//  Created by Courtney Pattison on 2017-05-31.
//  Copyright © 2017 Courtney Pattison. All rights reserved.
//

import UIKit

class AudiobookTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var audiobookTitleLabel: UILabel!
    @IBOutlet weak var audiobookAuthorsLabel: UILabel!
    @IBOutlet weak var audiobookRuntimeLabel: UILabel!
    @IBOutlet weak var audiobookRatingLabel: UILabel!
    @IBOutlet weak var audiobookImageView: UIImageView!
    
    // MARK: Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
