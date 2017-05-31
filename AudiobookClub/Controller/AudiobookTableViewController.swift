//
//  AudiobookTableViewController.swift
//  AudiobookClub
//
//  Created by Courtney Pattison on 2017-05-02.
//  Copyright © 2017 Courtney Pattison. All rights reserved.
//

import UIKit
import CoreData

class AudiobookTableViewController: UITableViewController {
    
    // MARK: Properties

    var audiobookViewController: AudiobookViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    //MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = splitViewController {
            let controllers = split.viewControllers
            audiobookViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? AudiobookViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

