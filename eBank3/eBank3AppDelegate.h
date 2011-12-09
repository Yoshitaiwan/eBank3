//
//  eBank3AppDelegate.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 17/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class RootViewController;

@interface eBank3AppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;    
    UINavigationController *navigationController;
    NSManagedObjectContext *managedObjectContext;	    
    NSManagedObjectModel* managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
//    RootViewController*  rootViewController;
    
}
//@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
//@property (nonatomic, retain) IBOutlet RootViewController*  rootViewController;


@property (nonatomic, retain,readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain,readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain,readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory ;


@end
