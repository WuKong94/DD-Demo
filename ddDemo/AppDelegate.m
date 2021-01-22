//
//  AppDelegate.m
//  ddDemo
//
//  Created by 孙武东 on 2021/1/15.
//

#import "AppDelegate.h"
#import "FirstVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    self.window.frame = [[UIScreen mainScreen] bounds];
    [self.window makeKeyAndVisible];
    
    
    self.window.rootViewController = [FirstVC new];
    
    return YES;
}


@end
