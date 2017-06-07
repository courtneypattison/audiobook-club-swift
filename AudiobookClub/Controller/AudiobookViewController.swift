//
//  AudiobookViewController.swift
//  AudiobookClub
//
//  Created by Courtney Pattison on 2017-05-02.
//  Copyright © 2017 Courtney Pattison. All rights reserved.
//

import UIKit

import AlamofireImage

class AudiobookViewController: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var audiobookTitleLabel: UILabel!
    @IBOutlet weak var audiobookAuthorsLabel: UILabel!
    @IBOutlet weak var audiobookDescriptionLabel: UILabel!
    @IBOutlet weak var audiobookSubjectsLabel: UILabel!
    @IBOutlet weak var audiobookRuntimeLabel: UILabel!
    @IBOutlet weak var audiobookRatingLabel: UILabel!
    @IBOutlet weak var audiobookImage: UIImageView!
    
    var audiobook: Audiobook?
    
    // MARK: Methods
    
    func configureView() {
        if let audiobook = audiobook {
            if let imageURL = audiobook.imageURL {
                var imageStr = String(describing: imageURL)
                imageStr = imageStr.replacingOccurrences(of: "_thumb", with: "")
                if let fullImageUrl = URL(string: imageStr) {
                    audiobookImage.af_setImage(withURL: fullImageUrl, filter: RoundedCornersFilter(radius: 5.0))
                }
            }
            if let title = audiobook.title {
                audiobookTitleLabel.text = title
            }
            if let authors = audiobook.authors?.joined(separator: ", ") {
                audiobookAuthorsLabel.text = authors
            }
            if let runtime = audiobook.runtime {
                audiobookRuntimeLabel.text = runtime.description()
            }
            if let rating = audiobook.rating {
                audiobookRatingLabel.text = String(rating)
            }
            if let subjects = audiobook.subjects {
                audiobookSubjectsLabel.text = subjects
            }
            if let description = audiobook.description {
                audiobookDescriptionLabel.text = description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: Actions
    
    @IBAction func playAudiobook(_ sender: UIButton) {
    }
    
    @IBAction func downloadAudiobook(_ sender: UIButton) {
    }
}

