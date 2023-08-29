//
//  PageViewController.swift
//  
//
//  Created by mac on 2023/08/25.
//

import UIKit

class PageViewController: UIPageViewController , UIPageViewControllerDataSource , UIPageViewControllerDelegate{
   
    var completeHandler: ((Int) -> ())?

    let viewsList: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "GroupGireViewController")
                let vc2 = storyboard.instantiateViewController(withIdentifier: "GroupBoyViewController")
                let vc3 = storyboard.instantiateViewController(withIdentifier: "SoloGireViewController")
                let vc4 = storyboard.instantiateViewController(withIdentifier: "SoloboyViewController")
                return [vc1, vc2, vc3, vc4]
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
             if index < 0 && index >= viewsList.count {return }
           self.setViewControllers([viewsList[index]], direction: .forward, animated: true, completion: nil)
           completeHandler?(currentIndex)
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
