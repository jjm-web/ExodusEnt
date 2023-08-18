//
//  MyInfoViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/14.
//

import UIKit

class MyInfoViewController: UIViewController {

    @IBOutlet var infoBtn: UIButton!
    @IBOutlet var historyBtn: UIButton!
    @IBOutlet var pgView: UIView!
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    var currentPage = 0
    
    let viewList:[UIViewController] = {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = storyBoard.instantiateViewController(identifier: "MyInfoViewController1")
        let vc2 = storyBoard.instantiateViewController(identifier: "MyInfoViewController2")
        
        return [vc1, vc2]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        viewChangeBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabbar()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    func viewChangeBtn() {
        //MARK: 앱 실행시 1번째 pageViewController 띄우기
        if let firstvc = viewList.first{
            //setViewControllers(첫번째화면, direction: .forward(앞으로), .reverse(뒤로), animated: 애니메이션(Bool), completion: nil)
            pageViewController.setViewControllers([firstvc], direction: .forward, animated: true, completion: nil)
        }
        
        infoBtn.isEnabled = true
        historyBtn.isEnabled = false
        
        //MARK: Main View안에 viewController 붙여넣기
        //pageViewController크기와 Main의 view크기와 맞춰서 addSubView로 main에 있는 view에 넣어준다.
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: pgView.frame.width, height: pgView.frame.height)
        self.pgView.addSubview(pageViewController.view)
    }
    
    @IBAction func infoAction(_ sender: UIButton) {
        //지금 페이지
        let infoPage = currentPage
        //화면 이동 (지금 페이지에서 setView 한다)
        pageViewController.setViewControllers([viewList[infoPage]], direction: .reverse, animated: true)
        
        //현재 페이지 잡아주기
        currentPage = pageViewController.viewControllers!.first!.view.tag
        enabledBtn()
    }
    
    @IBAction func historyAction(_ sender: UIButton) {
        //지금 페이지 + 1
        let historyPage = currentPage + 1
        //화면 이동 (지금 페이지에서 +1 페이지로 setView 한다)
        pageViewController.setViewControllers([viewList[historyPage]], direction: .forward, animated: true)
        
        //현재 페이지 잡아주기
        currentPage = pageViewController.viewControllers!.first!.view.tag
        enabledBtn()
    }
    
    func enabledBtn() {
        if currentPage == 0 {
            infoBtn.isEnabled = true
            historyBtn.isEnabled = false
        } else {
            infoBtn.isEnabled = false
            historyBtn.isEnabled = true
        }
    }

}

extension MyInfoViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,didFinishAnimating finished: Bool,previousViewControllers: [UIViewController],transitionCompleted completed: Bool){
        //현재페이지
        currentPage = pageViewController.viewControllers!.first!.view.tag
        enabledBtn()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //다음페이지 이동
        guard let index = viewList.firstIndex(of: viewController) else {return nil}
        let nextIndex = index + 1
        if nextIndex == viewList.count {return nil}
        return viewList[nextIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //이전페이지 이동
        guard let index = viewList.firstIndex(of: viewController) else {return nil}
        let previousIndex = index - 1
        if previousIndex < 0 { return nil }
        return viewList[previousIndex]
    }

}
