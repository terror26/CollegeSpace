import Foundation
import UIKit

func doSegueMan() {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as!UITabBarController ;
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.rootViewController = tabBarController ;
}
class Constants {
    static let Users = "Users"
    static let Date = "Date"
    static let location = "location"
    static let startTime = "startTime"
    static let endTime = "endTime"
    static let Time = "Time"
    static let Events = "Events"
    static let Votes = "Votes"
    static let names = "names"
    static let count = "count"
    static let nameTime = "Time"
    static let EMAIL = "Email"
    static let password = "Password"
    static let KEY_UID = "uid"
    static let Shadow_Color = 122.0 / 255.0
    static let EMAILIDCURRENT = "EMAILIDCURRENT"
}
