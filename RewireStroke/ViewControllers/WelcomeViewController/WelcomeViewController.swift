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
        WelcomePage(title: "Personalised Rehab", text: "A personalised exercise programme with \n upper limb, lower limb & balance \n workouts", image: "illustrationCircularIconGraph"),
        WelcomePage(title: "Monitor Progress", text: "Weekly targets help achieve recovery \n potential.", image: "illustrationMonitorProgress"),
        WelcomePage(title: "Optimise Recovery", text: "Rewire monitors and helps manage \n mood, fatigue and pain.", image:"illustrationOptimiseRecovery"),
        WelcomePage(title: "Unlock Workouts", text: "A simple assessment helps determine \n which exercises are appropriate.", image: "illustrationUnlockWorkouts"),
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
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
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
            
            
            let homeIcon = UIImage(named: "iconHome")!.withRenderingMode(.alwaysOriginal)
            let homeIconSelected = UIImage(named: "iconHomeSelected")!.withRenderingMode(.alwaysOriginal)
            let homeItem = UITabBarItem(title: "Home", image: homeIcon, selectedImage: homeIconSelected)
            homeItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
            homeItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colours.primaryIcon], for: .selected)

            let activityIcon = UIImage(named: "iconActivity")!.withRenderingMode(.alwaysOriginal)
            let activityIconSelected = UIImage(named: "iconActivitySelected")!.withRenderingMode(.alwaysOriginal)
            let activityItem = UITabBarItem(title: "Activity", image: activityIcon, selectedImage: activityIconSelected)
            activityItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
            activityItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colours.primaryIcon], for: .selected)

            let progressIcon = UIImage(named: "iconProgress")!.withRenderingMode(.alwaysOriginal)
            let progressIconSelected = UIImage(named: "iconProgressSelected")!.withRenderingMode(.alwaysOriginal)
            let progressItem = UITabBarItem(title: "Progress", image: progressIcon, selectedImage: progressIconSelected)
            progressItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
            progressItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colours.primaryIcon], for: .selected)

            let infoIcon = UIImage(named: "iconInfo")!.withRenderingMode(.alwaysOriginal)
            let infoIconSelected = UIImage(named: "iconInfoSelected")!.withRenderingMode(.alwaysOriginal)
            let infoItem = UITabBarItem(title: "Info", image: infoIcon, selectedImage: infoIconSelected)
            infoItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
            infoItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colours.primaryIcon], for: .selected)
            
            let profileIcon = UIImage(named: "iconProfile")!.withRenderingMode(.alwaysOriginal)
            let profileIconSelected = UIImage(named: "iconProfileSelected")!.withRenderingMode(.alwaysOriginal)
            let profileItem = UITabBarItem(title: "Profile", image: profileIcon, selectedImage: profileIconSelected)
            profileItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
            profileItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colours.primaryIcon], for: .selected)
            
            homeViewController.tabBarItem = homeItem
            activityViewController.tabBarItem = activityItem
            progressViewController.tabBarItem = progressItem
            infoViewController.tabBarItem = infoItem
            profileViewController.tabBarItem = profileItem
            
            let tabBarController = CustomTabController()
            let controllers = [infoViewController, progressViewController, homeViewController, activityViewController, profileViewController]
            tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
            
            tabBarController.selectedIndex = 2 // 2nd tab
            tabBarController.tabBar.unselectedItemTintColor = Colours.primaryIcon
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
