//
//  WelcomeViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 26/09/2020.
//  Copyright © 2020 Amy Ha. All rights reserved.
//

import UIKit

class WelcomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    let pages = [
        WelcomePage(title: "Personalised Rehab", text: "Upper limb, lower limb & balance \n workouts are tailored to meet your needs.", image: "illustrationCircularIconGraph"),
        WelcomePage(title: "Monitor Progress", text: "Weekly targets help achieve recovery potential.", image: "illustrationMonitorProgress"),
        WelcomePage(title: "Optimise Recovery", text: "Rewire monitors and helps manage mood, fatigue and pain.", image:"illlustrationOptimiseRecovery"),
        WelcomePage(title: "Get Started", text: "A simple assesssment will help us determine the appropriate exercises for your loved one.", image: "illustrationMockIphone"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .white
        collectionView?.register(WelcomePageCell.self, forCellWithReuseIdentifier: cellId)
        setupPageControl()
    }
    
    let pageControl = UIPageControl()
    fileprivate func setupPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        view.addSubview(pageControl)
        pageControl.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .init(width: 0, height: 50))
    }
    
    func scrollToNext() {
        guard let currentCell = collectionView?.visibleCells.first else { return }
        guard let index = collectionView?.indexPath(for: currentCell)?.item else { return }
        
        if index < pages.count - 1 {
            let nextIndexPath = IndexPath(item: index + 1, section: 0)
            collectionView?.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = index + 1
        } else {
            let homeViewController = HomeViewController.init(nibName: Constants.View.homeViewController, bundle: nil)
            let activityViewController = ActivityViewController.init(nibName: Constants.View.activityViewController, bundle: nil)
            let progressViewController = ProgressViewController.init(nibName: Constants.View.progressViewController, bundle: nil)
            let infoViewController = InfoViewController.init(nibName: Constants.View.infoViewController, bundle: nil)
            let profileViewController = ProfileViewController.init(nibName: Constants.View.profileViewController, bundle: nil)
            
            
            // tab bar icon
            let homeItem = UITabBarItem()
            homeItem.title = "Home"
            homeItem.image = UIImage(named: "iconHome")
            
            let activityItem = UITabBarItem()
            activityItem.title = "Activity"
            activityItem.image = UIImage(named: "iconActivity")

            let progressItem = UITabBarItem()
            progressItem.title = "Progress"
            progressItem.image = UIImage(named: "iconProgress")
            
            let infoItem = UITabBarItem()
            infoItem.title = "Info"
            infoItem.image = UIImage(named: "iconInfo")
            
            let profileItem = UITabBarItem()
            profileItem.title = "Profile"
            profileItem.image = UIImage(named: "iconProfile")
            
            homeViewController.tabBarItem = homeItem
            activityViewController.tabBarItem = activityItem
            progressViewController.tabBarItem = progressItem
            infoViewController.tabBarItem = infoItem
            profileViewController.tabBarItem = profileItem
            
            let tabBarController = UITabBarController()
            let controllers = [infoViewController, activityViewController, homeViewController, progressViewController, profileViewController]
            tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
            
            tabBarController.selectedIndex = 2 // 2nd tab
            view.window?.rootViewController = tabBarController
            view.window?.makeKeyAndVisible()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let index = x / view.frame.width
        pageControl.currentPage = Int(index)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WelcomePageCell
        cell.parentController = self
        cell.page = pages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.bounds.size
    }
    
}
