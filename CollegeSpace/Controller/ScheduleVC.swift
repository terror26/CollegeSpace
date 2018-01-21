
import UIKit

class ScheduleVC: UIViewController,UITableViewDataSource,UITableViewDelegate,implementmeAll {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var weekdayLbl: UILabel!
    
    var DetailsSessions = [EventCell]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataServices.instance.delegate2 = self
        
        DataServices.instance.populateSchedule()
        sortInOrder()
    }
    
    
    func sortInOrder() {
        if DetailsSessions.count > 0 {
            let size = DetailsSessions.count
            for i in 0..<size {
                for j in (i+1)..<size {
                    if ( DetailsSessions[i].votes < DetailsSessions[j].votes) {
                        let const = DetailsSessions[i]
                        DetailsSessions[i] = DetailsSessions[j]
                        DetailsSessions[j] = const
                    }
                }
            }
            for eachsession in DetailsSessions {
                print("Ordered is \(eachsession.votes)")
            }
        UpdateMainLbl();
        }
    } // sortinOrder
    
    func UpdateMainLbl() {
        if let weekday = getDayOfWeekString(today: DetailsSessions[0].date) {
            print("weekday is \(weekday)")
            weekdayLbl.text = weekday
        } else {
            print("bad input")
        }
        timeLbl.text = DetailsSessions[0].time
        dateLbl.text = DetailsSessions[0].date
    }
    
    
    func getDayOfWeekString(today:String)->String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let todayDate = formatter.date(from: today) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
            let myComponents = myCalendar.components(.weekday, from: todayDate)
            let weekDay = myComponents.weekday!
            switch weekDay {
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tuesday"
            case 4:
                return "Wednesday"
            case 5:
                return "Thursday"
            case 6:
                return "Friday"
            case 7:
                return "Saturday"
            default:
                print("Error fetching days")
                return nil
            }
        } else {
            return nil
        }
        
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
        sortInOrder()
        tableView.reloadData()

    }
    
}//VCEnds here

