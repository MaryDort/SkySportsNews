//
//  AppDelegate.m
//  News
//
//  Created by Mariia Cherniuk on 18.03.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "AppDelegate.h"
#import "MADDownloader.h"
#import "MADMasterTableViewController.h"
#import "MADDetailViewController.h"
#import "MADCoreDataStack.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    MADDetailViewController *detailVC = [[MADDetailViewController alloc] init];
    MADMasterTableViewController *masterVC = [[MADMasterTableViewController alloc] init];
    UINavigationController *masterNC = [[UINavigationController alloc] initWithRootViewController:masterVC];
    UINavigationController *detailNC = [[UINavigationController alloc] initWithRootViewController:detailVC];
    
    splitVC.viewControllers = @[masterNC, detailNC];
    masterVC.detailVC = detailVC;
    splitVC.view.backgroundColor = [UIColor whiteColor];
    splitVC.delegate = self;

    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window makeKeyAndVisible];
    _window.rootViewController = splitVC;
    
    masterVC.managedObjectContext = [[MADCoreDataStack sharedCoreDataStack] managedObjectContext];

    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskLandscape;
    } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
               && MAX([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width) == 736) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[MADDetailViewController class]] && ([(MADDetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

@end
