//
//  AudiobookViewController.swift
//  AudiobookClub
//
//  Created by Courtney Pattison on 2017-05-02.
//  Copyright © 2017 Courtney Pattison. All rights reserved.
//

import UIKit

class AudiobookViewController: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var audiobookTitleLabel: UILabel!
    @IBOutlet weak var audiobookAuthorsLabel: UILabel!
    @IBOutlet weak var audiobookDescriptionLabel: UILabel!
    @IBOutlet weak var audiobookGenresLabel: UILabel!
    @IBOutlet weak var audiobookRuntimeLabel: UILabel!
    @IBOutlet weak var audiobookRatingLabel: UILabel!
    @IBOutlet weak var audiobookImage: UIImageView!

    var audiobook: Audiobook?
    
    // MARK: Methods
    
    func configureView() {
        audiobook = Audiobook(identifier: "jane_eyre_ver03_0809_librivox",
                               title: "Jane Eyre (version 3)",
                               authors: ["Charlotte Brontë"],
                               description: "<a href=\"http://librivox.org/\" rel=\"nofollow\">LibriVox</a> recording of Jane Eyre, by Charlotte Brontë. Read by Elizabeth Klett.\n\n" +
                                "Charlotte Bronte's classic novel Jane Eyre is narrated by the title character, an orphan who survives neglect and abuse to become a governess at the remote Thornfield Hall. She finds a kindred spirit in her employer, the mysterious and brooding Mr. Rochester, but he hides a terrible secret that threatens their chances of happiness. (Summary by Elizabeth Klett)\n\n" +
                                "For further information, including links to online text, reader information, RSS feeds, CD cover or other formats (if available), please go to the LibriVox <a href=\"https://librivox.org/jane-eyre-version-3-by-charlotte-bronte/\" rel=\"nofollow\">catalog page</a> for this recording.\n\n" +
                                "For more free audio books or to become a volunteer reader, visit <a href=\"http://librivox.org/\" rel=\"nofollow\">LibriVox.org</a>.\n\n" +
                                "<a href=\"https://archive.org/download/jane_eyre_ver03_0809_librivox/JaneEyrepart1_librivox.m4b\" rel=\"nofollow\">Download M4B Part 1 (255MB)</a>\n" +
            "<a href=\"https://archive.org/download/jane_eyre_ver03_0809_librivox/JaneEyrepart2_librivox.m4b\" rel=\"nofollow\">Download M4B Part 2 (273MB)</a>\n",
                               genres: "librivox; audiobook; classic; romance;",
                               runtime: "18:36:29",
                               rating: 5.00,
                               image: URL(string: "https://ia802702.us.archive.org/18/items/jane_eyre_ver03_0809_librivox/Jane_Eyre_1002_thumb.jpg"),
                               chapters: [URL(string: "https://archive.org/download/jane_eyre_ver03_0809_librivox/janeeyre_01_bronte.mp3")]);
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

