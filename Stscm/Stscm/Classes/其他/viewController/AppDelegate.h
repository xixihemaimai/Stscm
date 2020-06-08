//
//  AppDelegate.h
//  Stscm
//
//  Created by mac on 2020/6/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic,strong)UIWindow * window;

@property(nonatomic,assign)BOOL allowRotation;//是否允许转向

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

