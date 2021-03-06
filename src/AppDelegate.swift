//
//  AppDelegate.swift
//  babyface
//
//  Created by Kevin Glover on 27/03/2015.
//  Copyright (c) 2015 Horizon. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
	var window: UIWindow?
	let navigationController = UINavigationController()

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
	{
		UIApplication.sharedApplication().statusBarStyle = .Default
		
		navigationController.navigationBar.translucent = true
		navigationController.setNavigationBarHidden(true, animated: false)
		navigationController.setToolbarHidden(true, animated: false)
		navigationController.toolbar.translucent = true

		navigationController.pushViewController(WelcomeViewController(), animated: false)
		
		window = UIWindow(frame: UIScreen.mainScreen().bounds)
		if let window = window
		{
			window.backgroundColor = UIColor.whiteColor()
			window.rootViewController = navigationController
			window.makeKeyAndVisible()
			window.layoutIfNeeded()
		}
		
		return true
	}

	func applicationWillResignActive(application: UIApplication)
	{
	}

	func applicationDidEnterBackground(application: UIApplication)
	{
	}

	func applicationWillEnterForeground(application: UIApplication)
	{
	}

	func applicationDidBecomeActive(application: UIApplication)
	{
	}

	func applicationWillTerminate(application: UIApplication)
	{
	}
}