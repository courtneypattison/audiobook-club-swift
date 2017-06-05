//
//  AudiobookTableViewController.swift
//  AudiobookClub
//
//  Created by Courtney Pattison on 2017-05-02.
//  Copyright © 2017 Courtney Pattison. All rights reserved.
//

import UIKit
import CoreData

import Alamofire
import AlamofireImage
import SwiftyJSON

class AudiobookTableViewController: UITableViewController {
    
    // MARK: Properties

    var audiobookViewController: AudiobookViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    var audiobooks = [Audiobook]()
    
    //MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = splitViewController {
            let controllers = split.viewControllers
            audiobookViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? AudiobookViewController
        }
        
        //loadSampleAudiobooks()
        loadAudiobooks()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    //MARK: Data Source Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudiobookTableViewCell",
                                                       for: indexPath) as? AudiobookTableViewCell else {
            fatalError("The dequeued cell is not an instance of AudiobookTableViewCell.")
        }
        
        let audiobook = audiobooks[indexPath.row]
        
        if let title = audiobook.title {
            cell.audiobookTitleLabel.text = title
        }
        if let authors = audiobook.authors?.joined(separator: ", ") {
            cell.audiobookAuthorsLabel.text = authors
        }
        if let runtime = audiobook.runtime {
            let runtimeArray = runtime.components(separatedBy: ":")
            if runtimeArray.count == 3 {
                let hours = runtimeArray[0] + "h"
                let minutes = runtimeArray[1] + "m"
                
                cell.audiobookRuntimeLabel.text = hours + " " + minutes
            }
        }
        if let rating = audiobook.rating {
            cell.audiobookRatingLabel.text = String(rating)
        }
        if let imageURL = audiobook.imageURL {
            cell.audiobookImageView.af_setImage(withURL: imageURL, filter: RoundedCornersFilter(radius: 5.0))
            
        }

        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audiobooks.count
    }
    
    //MARK: Private Methods
    
    func loadAudiobook(identifier: JSON) {
        if let identifier = identifier["identifier"].string {
            Alamofire.request("https://archive.org/details/" + identifier + "&output=json").responseJSON { response in
                if let jsonObject = response.result.value {
                    let json = JSON(jsonObject)
                    if let audiobook = Audiobook(data: json) {
                        self.audiobooks.append(audiobook)
                        print(identifier)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func loadAudiobooks() {
        audiobooks.removeAll()
        
        Alamofire.request("https://archive.org/advancedsearch.php?q=collection%3Alibrivoxaudio&fl[]=identifier&sort[]=downloads+desc&output=json").responseJSON { response in
            if let jsonObject = response.result.value {
                let json = JSON(jsonObject)
                let identifiers = json["response"]["docs"].arrayValue
                
                for identifier in identifiers {
                    self.loadAudiobook(identifier: identifier)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func loadSampleAudiobooks() {
        guard let audiobook1 = Audiobook(identifier: "jane_eyre_ver03_0809_librivox",
                                         title: "Jane Eyre (version 3)",
                                         authors: ["Charlotte Brontë"],
                                         description: "<a href=\"http://librivox.org/\" rel=\"nofollow\">LibriVox</a> recording of Jane Eyre, by Charlotte Brontë. Read by Elizabeth Klett.\n\n" +
                                            "Charlotte Bronte's classic novel Jane Eyre is narrated by the title character, an orphan who survives neglect and abuse to become a governess at the remote Thornfield Hall. She finds a kindred spirit in her employer, the mysterious and brooding Mr. Rochester, but he hides a terrible secret that threatens their chances of happiness. (Summary by Elizabeth Klett)\n\n" +
                                            "For further information, including links to online text, reader information, RSS feeds, CD cover or other formats (if available), please go to the LibriVox <a href=\"https://librivox.org/jane-eyre-version-3-by-charlotte-bronte/\" rel=\"nofollow\">catalog page</a> for this recording.\n\n" +
                                            "For more free audio books or to become a volunteer reader, visit <a href=\"http://librivox.org/\" rel=\"nofollow\">LibriVox.org</a>.\n\n" +
                                            "<a href=\"https://archive.org/download/jane_eyre_ver03_0809_librivox/JaneEyrepart1_librivox.m4b\" rel=\"nofollow\">Download M4B Part 1 (255MB)</a>\n" +
            "<a href=\"https://archive.org/download/jane_eyre_ver03_0809_librivox/JaneEyrepart2_librivox.m4b\" rel=\"nofollow\">Download M4B Part 2 (273MB)</a>\n",
                                         subjects: "librivox; audiobook; classic; romance;",
                                         runtime: "18:36:29",
                                         rating: 5.00,
                                         imageURL: URL(string: "https://ia802702.us.archive.org/18/items/jane_eyre_ver03_0809_librivox/Jane_Eyre_1002_thumb.jpg"),
                                         chapters: [URL(string: "https://archive.org/download/jane_eyre_ver03_0809_librivox/janeeyre_01_bronte.mp3")!]) else {
            fatalError("Unable to instantiate audiobook1")
        }
        
        guard let audiobook2 = Audiobook(identifier: "bonnie_prince_charlie_1503_librivox",
                                         title: "",
                                         authors: ["Shenzi", "Raj"],
                                         description: "Cats are the coolest",
                                         subjects: "cats;",
                                         runtime: "10:36:20",
                                         imageURL: URL(string: ""),
                                         chapters: [URL(string: "https://archive.org/download/jane_eyre_ver03_0809_librivox/janeeyre_01_bronte.mp3")!]) else {
                                            fatalError("Unable to instantiate audiobook2")
        }
        
        audiobooks.append(audiobook1)
        audiobooks.append(audiobook2)
    }

}

