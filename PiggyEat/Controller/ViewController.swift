//
//  ViewController.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 2/12/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    private var pageViewController: UIPageViewController!
    private let pageViewDataSource = ["Breakfast", "Lunch", "Dinner"]
    private var currentViewIndex = 0
    private var pendingViewControllerIndex = 0
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let menu = Menu.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu.loadData(context: context)
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        //        guard let selectedFood = menu.foodArray.randomElement()?.name else{
        //            //foodChoice.text = "Empty menu!"
        //            return
        //        }
        //foodChoice.text = selectedFood
        print("The current index is \(currentViewIndex)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPageViewController" {
            if let vc = segue.destination as? UIPageViewController {
                pageViewController = vc
                pageViewController.delegate = self
                pageViewController.dataSource = self
                
                guard let firstViewController = initDataViewController(index: currentViewIndex) else {
                    return
                }
                pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
                
            }
        }
    }
    
    private func initDataViewController(index: Int) -> DataViewController? {
        
        if index >= pageViewDataSource.count || pageViewDataSource.count == 0 {
            return nil
        }
        
        let dataViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DataViewController") as? DataViewController
        dataViewController?.index = index
        dataViewController?.displayImage = UIImage(named: pageViewDataSource[index])
        return dataViewController
    }
}


//MARK: - UIPageViewController Protocols

extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewDataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? DataViewController
        
        guard let currentIndex = dataViewController?.index else {
            return nil
        }
        
        currentViewIndex = currentIndex
        let previousIndex = currentIndex - 1
        
        guard previousIndex >= 0 else {
            return initDataViewController(index: pageViewDataSource.count - 1)
        }
        
        guard pageViewDataSource.count > previousIndex else {
            return nil
        }
        
        return initDataViewController(index: previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? DataViewController
        
        guard let currentIndex = dataViewController?.index else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        currentViewIndex = currentIndex
        
        guard pageViewDataSource.count != nextIndex else {
            return initDataViewController(index: 0)
        }
        
        guard pageViewDataSource.count > nextIndex else {
            return nil
        }
        
        return initDataViewController(index: nextIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let nextViewController = pendingViewControllers[0] as? DataViewController {
            pendingViewControllerIndex = nextViewController.index
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentViewIndex = pendingViewControllerIndex
        }
    }
    
}
