//
//  AccountStatementController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 25/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "StatementEntity.h"

@interface AccountStatementController : UITableViewController
{
@private 
   // NSArray* details_;    
   // NSArray* keys_;
   // NSDictionary* dataSource_;
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
    
    NSNumberFormatter* formatter;
    StatementEntity* stmtEntity ; 
    

}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSNumberFormatter* formatter;
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil context:(NSManagedObjectContext *) context;
-(void) downloadAndSaveStatement:(NSManagedObjectContext *)context   ;

@end
