//
//  CalculAppDelegate.m
//  Calcul
//
//  Created by Fan ZHAO on 11-4-6.
//  Copyright 2011年 Personne. All rights reserved.
//

#import "CalculAppDelegate.h"

@implementation CalculAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    [self performSelector:@selector(getIntoMainMenu) withObject:nil afterDelay:2];
    return YES;
}

     
- (void)getIntoMainMenu{
//    UINavigationController *navController = [[UINavigationController alloc]init];

    //Create the view for the tests
    test1ViewController * test1View = [[test1ViewController alloc]init];
    [test1View setTitle:@"Test 1 Échantillon"];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"test1" image:[UIImage imageNamed:@"01-refresh.png"] tag:0];
    test1View.tabBarItem = item;

    test2ViewController * test2View = [[test2ViewController alloc] init];
    [test2View setTitle:@"Test 2 Précision en %"];
    item = [[UITabBarItem alloc] initWithTitle:@"test2" image:[UIImage imageNamed:@"02-redo.png"] tag:1];
    test2View.tabBarItem = item;
  
    
    test3ViewController * test3View = [[test3ViewController alloc] init];
    [test3View setTitle:@"Test 3 Précision en moyenne"];
    item = [[UITabBarItem alloc] initWithTitle:@"test3" image:[UIImage imageNamed:@"03-loopback.png"] tag:2];
    test3View.tabBarItem = item;

    
    test4ViewController * test4View = [[test4ViewController alloc] init];
    [test4View setTitle:@"Test 4 Signficativité d'un écart"];
    item = [[UITabBarItem alloc] initWithTitle:@"test4" image:[UIImage imageNamed:@"04-squiggle.png"] tag:3];
    test4View.tabBarItem = item;
    
    test5ViewController * test5View = [[test5ViewController alloc] init];
    [test5View setTitle:@"Test 4 Signficativité d'un écart"];
    item = [[UITabBarItem alloc] initWithTitle:@"test5" image:[UIImage imageNamed:@"05-shuffle.png"] tag:4];
    test5View.tabBarItem = item;
    
    
//    //Create the page sommaire
//    MainMenuController *mainMenuCtl = [[MainMenuController alloc]initWithStyle:UITableViewStyleGrouped];
//    [mainMenuCtl setTitle:@"HOME"];
//    [mainMenuCtl setTest1:test1View];
    
    //associer;
    
//    UINavigationController * nav = [[UINavigationController alloc] init];
//    [nav pushViewController:mainMenuCtl animated:NO];
//    
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects:test1View, test2View, test3View, test4View, test5View, nil ];
    
    
    //release
    //  [nav release];
    [test1View release];
    [test2View release];
    [test3View release];
    [test4View release];
    [test5View release];
    [item release];
    [self.window addSubview:tabBarController.view];
}
     
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

#pragma mark - Display the selectors called
/*
 This function can display the Selector called.
 */
- (BOOL)respondsToSelector:(SEL)aSelector {
	NSString *methodName = NSStringFromSelector(aSelector);
	NSLog(@"respondsToSelector:%@", methodName); 
	return [super respondsToSelector:aSelector];
}


@end
