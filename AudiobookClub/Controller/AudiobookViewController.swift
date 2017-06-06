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
            audiobookTitleLabel.text = audiobook.title ?? ""
            audiobookAuthorsLabel.text = audiobook.authors?.joined(separator: ", ")
            audiobookDescriptionLabel.text = audiobook.description ?? ""
            audiobookSubjectsLabel.text = audiobook.subjects ?? ""
            audiobookRuntimeLabel.text = audiobook.runtime?.description()
            if let imageURL = audiobook.imageURL {
                audiobookImage.af_setImage(withURL: imageURL)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: Actions
    
    @IBAction func downloadAudiobook(_ sender: UIButton) {
    }
    

}

