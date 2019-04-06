import UIKit
import Foundation
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let api = ChatAPI()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        // ChatAPI
        api.connect { [unowned self] newMessege in
            self.persist(messages: newMessege)
        }
        
        let statsVC = StatsViewController()
        statsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        let chatterVC = ChatterViewController()
        chatterVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        let navController = UINavigationController(rootViewController: chatterVC)
        let tabController = UITabBarController()
        tabController.viewControllers = [statsVC, navController]
        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
        return true
    }
    
    private func persist(messages: [(String, String)]) {
        // Persist a list of messages to database
        print(messages)
        SyncManager.shared.logLevel = .off
        
        DispatchQueue.global(qos: .background).async {
            let objects = messages.map { message in
                return Message(from: message.0, text: message.1)
            }
            let realm = try! Realm()
            try! realm.write {
                realm.add(objects)
            }
        }
        

    }




}

