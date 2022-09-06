//
//  PageViewController.swift
//  ExodusEnt
//
//  Created by mac on 2022/12/27.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource , UIPageViewControllerDelegate {
    
    
    var completeHandler : ((Int)->())?
        
        let viewsList : [UIViewController] = {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
           
            let vc1 = storyBoard.instantiateViewController(withIdentifier: "PrivacyViewController")
            let vc2 = storyBoard.instantiateViewController(withIdentifier: "UsegeHistoryViewController")
         
            
            return [vc1, vc2]
            
        }()
        
        
        var currentIndex : Int {
            guard let vc = viewControllers?.first else { return 0 }
            return viewsList.firstIndex(of: vc) ?? 0
        }

        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.dataSource = self
            self.delegate = self
            
            if let firstvc = viewsList.first {
                self.setViewControllers([firstvc], direction: .forward, animated: true, completion: nil)
            }
            
        }
        
        func setViewcontrollersFromIndex(index : Int){
            if index == 0 {
                self.setViewControllers([viewsList[0]], direction: .reverse, animated: true, completion: nil)
                completeHandler?(currentIndex)
            } else {
                self.setViewControllers([viewsList[1]], direction: .forward, animated: true, completion: nil)
                completeHandler?(currentIndex)
            }
        }
    
        
         func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed {
                
                completeHandler?(currentIndex)
            }
        }
        
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
            guard let index = viewsList.firstIndex(of: viewController) else {return nil}
            
            let previousIndex = index - 1
            
            if previousIndex < 0 { return nil}
            
            return viewsList[previousIndex]
            
            
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
            
            guard let index = viewsList.firstIndex(of: viewController) else {return nil}
                  
            let nextIndex = index + 1
                  
            if nextIndex == viewsList.count { return nil}
                  
            return viewsList[nextIndex]
                  
            
        }
        
    }
