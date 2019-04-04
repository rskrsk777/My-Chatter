import UIKit

class StatsViewController: UIViewController {

    var titleLabel: UILabel!
    var totalMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        setupLabel()
    }
    
    
    func setupLabel () {
        titleLabel = {
            let label = UILabel()
            label.text = "Chatter"
            label.font = UIFont.systemFont(ofSize: 40)
            label.sizeToFit()
            label.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            label.textColor = UIColor.white
            view.addSubview(label)
            return label
        }()
        
        totalMessageLabel = {
            let label = UILabel()
            label.text = "Total Message"
            label.font = UIFont.systemFont(ofSize: 20)
            label.sizeToFit()
            label.textColor = UIColor.white
            label.center.x = UIScreen.main.bounds.midX
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            return label
        }()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        totalMessageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
        totalMessageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        print(totalMessageLabel.frame)
    }


}

