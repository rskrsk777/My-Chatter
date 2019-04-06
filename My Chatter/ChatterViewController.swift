//
//  ChatterViewController.swift
//  My Chatter


import UIKit
import RealmSwift

class ChatterViewController: UITableViewController {
    
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter
    }()
    
    private var messages: Results<Message>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm()
        messages = realm.objects(Message.self).sorted(byKeyPath: Message.properties.date, ascending: false)
    }

    func setupNav () {
        self.navigationItem.title = "Message"
        self.navigationController?.navigationBar.barTintColor = UIColor.purple
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationItem.setLeftBarButton(editButtonItem, animated: true)
    }
    

}


extension ChatterViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value2, reuseIdentifier: "Cell")
        let message = messages![indexPath.row]
        cell.contentView.backgroundColor = message.isNew ? UIColor.white : UIColor.lightGray
        let formattedDate = formatter.string(from: message.date)
        cell.textLabel?.text = message.isNew ? "[\(message.from)]" : message.from
        cell.detailTextLabel?.text = String(format: "(%@) %@", formattedDate, message.text)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let message = messages?[indexPath.row], editingStyle == .delete else {
            return
        }
        deleteMessage(message)
        tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.isEditing = editing
    }
    
    func deleteMessage (_ message: Message) {
        message.delete()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages![indexPath.row]
        let realm = try! Realm()
        realm.beginWrite()
        message.isNew = false
        try! realm.commitWrite()
        tableView.reloadData()
    }
}
