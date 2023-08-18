//
//  RangKingViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/10/18.
//

import UIKit
import SDWebImage
import FirebaseStorage
class RangKingViewController: UIViewController {
    
    let storage = Storage.storage()
    var formatter_time = DateFormatter()
    
    @IBOutlet var soloBoyView: UIView!
    @IBOutlet var soloGireView: UIView!
    @IBOutlet var groupBoyView: UIView!
    @IBOutlet var groupGireView: UIView!
    
    @IBOutlet var img_1: UIImageView!
    @IBOutlet var img_2: UIImageView!
    @IBOutlet var img_3: UIImageView!
    
    @IBOutlet var lblTimer: UILabel!
    
    @IBOutlet var segmented: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmented.addUnderlineForSelectedSegment()
        
        idolimage(imgview: img_1)
        idolimage(imgview: img_2)
        idolimage(imgview: img_3)
        
        self.soloBoyView.isHidden = false
        self.soloGireView.isHidden = true
        self.groupBoyView.isHidden = true
        self.groupGireView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabbar()
        
        navigationController?.isNavigationBarHidden = true

        formatter_time.dateFormat = "HH:mm:ss"
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MainViewController.timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        let timer = formatter_time.string(from: Date())
        lblTimer.text = "랭킹 갱신까지! \(timer)"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func segmentedControlDidChange(_ sender: UISegmentedControl) {
        segmented.changeUnderlinePosition()
        idolimage(imgview: img_1)
        idolimage(imgview: img_2)
        idolimage(imgview: img_3)
    }
    

    
    func idolimage(imgview: UIImageView) {
        
        
        if segmented.selectedSegmentIndex == 0 {
            
            storage.reference(forURL: "gs://exodusent-5d233.appspot.com/boysoloidol/boy_1.jpeg").downloadURL { url, error in
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self.img_1.image = image
                
                
            }
            storage.reference(forURL: "gs://exodusent-5d233.appspot.com/boysoloidol/boy_2.jpeg").downloadURL { url, error in
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self.img_2.image = image
            }
            storage.reference(forURL: "gs://exodusent-5d233.appspot.com/boysoloidol/boy_3.jpeg").downloadURL { url, error in
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self.img_3.image = image
            }
            
            self.soloBoyView.isHidden = false
            self.soloGireView.isHidden = true
            self.groupBoyView.isHidden = true
            self.groupGireView.isHidden = true
            
        } else if segmented.selectedSegmentIndex == 1 {
            storage.reference(forURL: "gs://exodusent-5d233.appspot.com/giresoloidol/gire_1.jpeg").downloadURL { url, error in
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self.img_1.image = image
            }
            storage.reference(forURL: "gs://exodusent-5d233.appspot.com/giresoloidol/gire2.jpeg").downloadURL { url, error in
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self.img_2.image = image
            }
            storage.reference(forURL: "gs://exodusent-5d233.appspot.com/giresoloidol/gire_3.jpeg").downloadURL { url, error in
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self.img_3.image = image
            }
            
            self.soloBoyView.isHidden = true
            self.soloGireView.isHidden = false
            self.groupBoyView.isHidden = true
            self.groupGireView.isHidden = true
            
        } else if segmented.selectedSegmentIndex == 2 {
            storage.reference(forURL: "gs://exodusent-5d233.appspot.com/boygroupidol/boygroup_1.jpeg").downloadURL { url, error in
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self.img_1.image = image
            }
            storage.reference(forURL: "gs://exodusent-5d233.appspot.com/boygroupidol/boygroup_2.jpeg").downloadURL { url, error in
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self.img_2.image = image
            }
            storage.reference(forURL: "gs://exodusent-5d233.appspot.com/boygroupidol/boygroup_3.jpeg").downloadURL { url, error in
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self.img_3.image = image
            }
            
            self.soloBoyView.isHidden = true
            self.soloGireView.isHidden = true
            self.groupBoyView.isHidden = false
            self.groupGireView.isHidden = true
            
            
        } else if segmented.selectedSegmentIndex == 3 {
            storage.reference(forURL: "gs://exodusent-5d233.appspot.com/giregroupidol/giregroup_1.jpeg").downloadURL { url, error in
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self.img_1.image = image
            }
            storage.reference(forURL: "gs://exodusent-5d233.appspot.com/giregroupidol/giregroup_2.jpeg").downloadURL { url, error in
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self.img_2.image = image
            }
            storage.reference(forURL: "gs://exodusent-5d233.appspot.com/giregroupidol/giregroup_3.jpeg").downloadURL { url, error in
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self.img_3.image = image
            }
            
            self.soloBoyView.isHidden = true
            self.soloGireView.isHidden = true
            self.groupBoyView.isHidden = true
            self.groupGireView.isHidden = false
            
        }
    }
    
}


extension UIView {
    func viewBottomLine(color:UIColor,height:Double)
    {
        //Hiding Default Line and Shadow
        //Creating New line
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: height))
        lineView.backgroundColor = color
        self.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true

    }
}


