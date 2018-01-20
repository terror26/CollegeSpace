
import UIKit

class ScheduleVC: UIViewController,UITableViewDataSource,UITableViewDelegate,implementmeAll {
    
    @IBOutlet weak var tableView: UITableView!
    
    var DetailsSessions = [EventCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataServices.instance.delegate2 = self
        DataServices.instance.populateSchedule()
    }
    
    func getAllDetails(Schedule: [EventCell]?) {
        DetailsSessions.removeAll()
        for firstsession in Schedule! {
            DetailsSessions.append(firstsession)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailsSessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventAdded") as?EventAdded {
            cell.configureCell2(eventCell: DetailsSessions[indexPath.row])
            print("#############data here is \(DetailsSessions[indexPath.row].votes)########++++++++++")
            return cell
        }
        return EventAdded()
    }
    @IBAction func RefreshBtnPressed(_ sender: Any) {
        DataServices.instance.populateSchedule()
        tableView.reloadData()

    }
    
}//VCEnds here

