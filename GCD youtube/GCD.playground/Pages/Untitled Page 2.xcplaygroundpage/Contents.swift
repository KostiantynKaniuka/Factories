//: [Previous](@previous)

import UIKit
import PlaygroundSupport


class MyVievController: UIViewController {
    
    
    
    
    var button = UIButton()
    let vc = SecondVievController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc"
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
     initButton()
    }
    
    func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.setTitle("Press", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        view.addSubview(button)
    }
    
  
   @objc func pressButton() {
     
       navigationController?.pushViewController(vc, animated: true)
    }
    
}






let vc = MyVievController()
let navbar = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = navbar


class SecondVievController: UIViewController {
    var button = UIButton()
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "VC2"
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initImage()
    }
    
    func initImage() {
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.center = view.center
        view.addSubview(imageView)
        let imageURL = URL(string: "https://yourtechdiet.com/wp-content/uploads/2022/01/Best-AI-tools-for-Image-Processing.jpg")!
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
        
            }
        }
     
                
        }
    
    func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.setTitle("Press", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        view.addSubview(button)
    }
    
   @objc func pressButton() {
        print("Hello everynijan😺")
    }
    
}
