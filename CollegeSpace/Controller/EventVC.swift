//
//  EventVC.swift
//  CollegeSpace
//
//  Created by Kanishk Verma on 17/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import UIKit

class EventVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var sessions = [EventCell]()
    let cell1 = EventCell(date: "8/10/12", location: "bengal", starttime: "10:00Am", endtime: "11:00Am")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessions.append(cell1);
        DataServices.instance.populateSessions();
        
        // Do any additional setup after loading the view.
    }

}

//has the table view and then the implementMe func
extension EventVC:UITableViewDelegate,UITableViewDataSource,implementMe {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventAdded") as?EventAdded {
            cell.configureCell(eventCell: sessions[indexPath.row])
            print(" +++++++++++++++++++ \(sessions[indexPath.row].date) ++++++++++++++++++")
            return cell
        } else {
            print("Ramram")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.sessions.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .middle)
            tableView.endUpdates()
        }
    }
    
    func getInfoforTime(date: String?, location: String?, starttime: String?, endtime: String?) {
        if date == nil {
            return
        }
        
        let timedemo:String = "\(starttime)-\(endtime)";
        print("YoMan")
        DataServices.instance.saveInFirebaseNames(Name: "Kanishk", date: date!, time: timedemo)
    }
}



















