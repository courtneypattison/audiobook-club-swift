//
//  AudiobookTableViewController.swift
//  AudiobookClub
//
//  Created by Courtney Pattison on 2017-05-02.
//  Copyright © 2017 Courtney Pattison. All rights reserved.
//

import CoreData
import os.log
import UIKit

import Alamofire
import Kingfisher
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
        
        loadAudiobooks()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAudiobookDetail" {
            guard let audiobookDetailViewController = (segue.destination as! UINavigationController).topViewController as? AudiobookViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedAudiobookCell = sender as? AudiobookTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedAudiobookCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedAudiobook = audiobooks[indexPath.row]
            audiobookDetailViewController.audiobook = selectedAudiobook
            audiobookDetailViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            audiobookDetailViewController.navigationItem.leftItemsSupplementBackButton = true
        }
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
        } else {
            cell.audiobookTitleLabel.text = "Unknown title"
        }
        
        if let authors = audiobook.authors?.joined(separator: ", ") {
            cell.audiobookAuthorsLabel.text = authors
        } else {
            cell.audiobookAuthorsLabel.text = "Unknown author(s)"
        }
        
        if let runtime = audiobook.runtime {
            cell.audiobookRuntimeLabel.text = runtime.description()
        } else {
            cell.audiobookRuntimeLabel.text = "Unknown runtime"
        }
        
        if let rating = audiobook.rating {
            cell.audiobookStarRating.rating = rating
        } else {
            cell.audiobookStarRating.rating = 0
        }
        
        if let imageURL = audiobook.imageURL {
            let processor = RoundCornerImageProcessor(cornerRadius: 5)
            cell.audiobookImageView.kf.setImage(with: imageURL, options: [.processor(processor)])
        } else {
            cell.audiobookImageView.image = UIImage(named: "coverPlaceholder")
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
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if let audiobook = Audiobook(data: json) {
                        self.audiobooks.append(audiobook)
                    }
                    self.tableView.reloadData()
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
                
            }
        }
    }
    
    func loadAudiobooks() {
        audiobooks.removeAll()
        
        Alamofire.request("https://archive.org/advancedsearch.php?q=collection%3Alibrivoxaudio&fl[]=identifier&sort[]=downloads+desc&output=json").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let identifiers = json["response"]["docs"].arrayValue
                
                for identifier in identifiers {
                    self.loadAudiobook(identifier: identifier)
                }
                self.tableView.reloadData()
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}

