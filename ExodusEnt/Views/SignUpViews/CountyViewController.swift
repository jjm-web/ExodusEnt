//
//  CountyViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/12.
//

import UIKit
import IQKeyboardManagerSwift

protocol SampleProtocol {
  func dataSend(countryData: String)
}

class CountyViewController: UIViewController {
 
    var dataSource : [String] = ["USA", "Bahamas", "Brazil", "Canada", "Republic of China", "Cuba", "Egypt", "Fiji", "France", "Germany", "Iceland", "India", "Indonesia", "Jamaica", "Kenya", "Korea", "Madagascar", "Mexico", "Nepal", "Oman", "Pakistan", "Poland", "Singapore", "Somalia", "Switzerland", "Turkey", "UAE", "Vatican City"]
    
    var filteredDataSource: [String] = ["USA", "Bahamas", "Brazil", "Canada", "Republic of China", "Cuba", "Egypt", "Fiji", "France", "Germany", "Iceland", "India", "Indonesia", "Jamaica", "Kenya", "Korea", "Madagascar", "Mexico", "Nepal", "Oman", "Pakistan", "Poland", "Singapore", "Somalia", "Switzerland", "Turkey", "UAE", "Vatican City"]
   
    
    var delegate : SampleProtocol?
    
    @IBOutlet var tblCountry: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var accessBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
    }
   
    
    @IBAction func btnAction(_ sender: UIButton) {
        if let text = searchBar.text{
              delegate?.dataSend(countryData: text)
            }
            
            //4. delegate 처리가 끝난 뒤에, navigation pop처리
            self.dismiss(animated: true)
          }
    }
extension CountyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCountry.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = dataSource[indexPath.row]
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(dataSource[indexPath.row])
        searchBar.text = dataSource[indexPath.row]
        //countryData = searchBar.text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text: String = self.searchBar.text ?? ""
        self.dataSource = []
        for item in self.filteredDataSource {
            if (item.lowercased().contains(text.lowercased())) {
                self.dataSource.append(item)
            }
        }
        if (text.isEmpty) {
            self.dataSource = self.filteredDataSource
        }
        self.tblCountry.reloadData()
        
    }
}

extension CountyViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // TODO...
    }
}

