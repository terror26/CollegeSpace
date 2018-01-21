//
//  EventVC.swift
//  CollegeSpace
//
//  Created by Kanishk Verma on 17/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

// added by the current user only
import UIKit
import SwiftKeychainWrapper

class EventVC: UIViewController,UITableViewDelegate,UITableViewDataSource,implementMeSessions,implementSaved {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var Sessionsninfo = [EventCell]()
    var addEventVC = AddEventVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        addEventVC.delegatesaved = self
        DataServices.instance.delegate = self
        DataServices.instance.populateSessions();
        tableView.reloadData()
     
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        DataServices.instance.populateSessions();
        tableView.reloadData()
    }
    
    func getbackSaved(Event: EventCell?) {
        Sessionsninfo.append(Event!)
        tableView.reloadData()
    }
    
    func getSessionDetails(sessions: [EventCell]?) {
        Sessionsninfo.removeAll()
        
        for firstsession in sessions! {
            Sessionsninfo.append(firstsession)
        }

        tableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sessionsninfo.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventAdded") as?EventAdded {
            cell.configureCell(eventCell: Sessionsninfo[indexPath.row])
            
            print(" +++++++++++++++++++ \(self.Sessionsninfo[indexPath.row].date) ++++++++++++++++++")
            return cell
            
        } else {
            print("Ramram")
            return EventAdded()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // deletefunctionality
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let required = Sessionsninfo[indexPath.row]

            DataServices.instance.names.child(KeychainWrapper.standard.string(forKey:Constants.EMAILIDCURRENT)!).child(required.date).removeValue()
            self.Sessionsninfo.remove(at: indexPath.row)
            
            DataServices.instance.checkforVotes(required:required)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .middle)
            tableView.endUpdates()
        }
    }
    @IBAction func RefreshBtn(_ sender: Any) {
        DataServices.instance.populateSchedule()
    tableView.reloadData()
    }
    
    
}



















