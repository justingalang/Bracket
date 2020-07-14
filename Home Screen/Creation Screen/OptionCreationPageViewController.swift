//
//  OptionCreationPageViewController.swift
//  BrackIt
//
//  Created by Justin Galang on 6/4/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class OptionCreationPageViewController: UIPageViewController {
	
	var optionTextArray = [String]()
	let defaults = UserDefaults.standard
	struct Storyboard {
		static let optionCreationViewController = "optionCreationViewController"
	}
	
	lazy var controllers: [UIViewController] = {
		let storyboard = UIStoryboard(name: "Creation", bundle: nil)
		var controllers = [UIViewController]()
		let pageCount = (defaults.integer(forKey: "newTournamentSize"))/8
		
		for i in 0..<pageCount {
			let pageVC = storyboard.instantiateViewController(withIdentifier: Storyboard.optionCreationViewController)
			controllers.append(pageVC)
		}
	
		
		return controllers
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		automaticallyAdjustsScrollViewInsets = false
		dataSource = self
		delegate = self
        
		self.turnToPage(index: 0)
    }
	func turnToPage(index: Int) {
		let controller = controllers[index]
		var direction = UIPageViewController.NavigationDirection.forward
		
		if let currentVC = viewControllers?.first {
			let currentIndex = controllers.firstIndex(of: currentVC)!
			if currentIndex > index {
				direction = .reverse
			}
		}
		self.configureDisplaying(viewController: controller)
		
		setViewControllers([controller], direction: direction, animated: true, completion: nil)
	}
	
	func configureDisplaying(viewController: UIViewController) {
		for (index, vc) in controllers.enumerated() {
			if viewController === vc {
				//if let shoeImageVC = viewController as? OptionCreationPageViewController
			}
		}
	}
}

extension OptionCreationPageViewController: UIPageViewControllerDataSource {
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		if let index = controllers.firstIndex(of: viewController) {
			if index > 0 {
				return controllers [index - 1]
			}
		}
		return controllers.last
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		if let index = controllers.firstIndex(of: viewController) {
			if index < controllers.count - 1 {
				return controllers[index + 1]
			}
		}
		return controllers.first
	}
}

extension OptionCreationPageViewController : UIPageViewControllerDelegate{
	func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
		self.configureDisplaying(viewController: pendingViewControllers.first as! OptionCreationPageViewController)
	}
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		if !completed {
			self.configureDisplaying(viewController: previousViewControllers.first as! OptionCreationPageViewController)
		}
	}
}
