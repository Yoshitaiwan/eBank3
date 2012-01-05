//
//  AccountStatementController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 25/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "StatementGroupEntity.h"
#import "BalanceRecordEntity.h"

@interface AccountStatementController : UITableViewController
{
@private 
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
    
    NSNumberFormatter* formatter;
    StatementGroupEntity* stmtGroupEntity ; 
    BalanceRecordEntity* lastSelectedBalanceRecordEntity ;

}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSNumberFormatter* formatter;
@property (nonatomic, retain) BalanceRecordEntity* lastSelectedBalanceRecordEntity ; 


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil context:(NSManagedObjectContext *) context;
-(void) downloadAndSaveStatement:(NSManagedObjectContext *)context   ;

@end
