//
//  AccountStatementController.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 25/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AccountStatementController.h"
#import "AccountStatementTransactionController.h"
#import "Statement.pb.h"
#import "StatementGroupEntity.h"
#import "StatementRecordEntity.h"
#import "DateTimeHelper.h"

#import "AccountStatementTransactionController.h"

#define kStatementRecordEntity @"StatementRecordEntity"
#define kStatementGroupEntity  @"StatementGroupEntity"

@implementation AccountStatementController

@synthesize managedObjectContext, fetchedResultsController, formatter,lastSelectedBalanceRecordEntity;

- (void)dealloc
{
    [managedObjectContext release];
    [fetchedResultsController release];
    [formatter release];
    [lastSelectedBalanceRecordEntity release];
    [super dealloc];
}


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil context:(NSManagedObjectContext *) context
{
    if (self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
        self.managedObjectContext = context;
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad called1");
    
    self.navigationItem.title =@"Transactions";
    
    formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
   
    NSLog(@"viewDidLoad called2");
    [self fetchResultsController];  // this fetch is to find if the data needs to be downloaded from ggl
 
    StatementRecordEntity* recordEntity = [[fetchedResultsController fetchedObjects] lastObject];
    NSNumber* timeStampOfStatement  = recordEntity.timeStampInserted;
    NSNumber* timeStampOfBalance =  lastSelectedBalanceRecordEntity.timeStampInserted;
    
    // if there is no data in coreData, then download from ggl
    if ([[fetchedResultsController fetchedObjects]count] == 0) {
        NSString *urlString = [NSString stringWithFormat:@"http://localhost:8082/gs?book_ac="];
        urlString = [urlString stringByAppendingString:lastSelectedBalanceRecordEntity.book];
        urlString = [urlString stringByAppendingString:@"_"];
        urlString = [urlString stringByAppendingString:lastSelectedBalanceRecordEntity.account];
     
        [self downloadAndSaveStatement:self.managedObjectContext withURLString:urlString];
        
        //if there is data in coreData, but not fully updated then download from ggl    
    }else if (timeStampOfBalance >timeStampOfStatement){              
        NSString *urlString = [NSString stringWithFormat:@"http://localhost:8082/gs?book_ac="];
        urlString = [urlString stringByAppendingString:lastSelectedBalanceRecordEntity.book];
        urlString = [urlString stringByAppendingString:@"_"];
        urlString = [urlString stringByAppendingString:lastSelectedBalanceRecordEntity.account];
        urlString = [urlString stringByAppendingString:@"&timeStampInsert="];
        urlString = [urlString stringByAppendingString:[[lastSelectedBalanceRecordEntity timeStampInserted] stringValue]];
        
        [self downloadAndSaveStatement:self.managedObjectContext withURLString:urlString];
        
        [self deleteAllObjects:@"BalanceRecordEntity"];
        // Update balance data as well 
        
    }

}

-(void)fetchResultsController
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:kStatementRecordEntity inManagedObjectContext:self.managedObjectContext];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"timeStampInserted" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"account == %@", lastSelectedBalanceRecordEntity.account];
    
    request.fetchBatchSize = 20;
    
    fetchedResultsController = [[NSFetchedResultsController alloc]
                                initWithFetchRequest:request 
                                managedObjectContext:managedObjectContext 
                                sectionNameKeyPath:@"date" 
                                cacheName:kStatementRecordEntity];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }	
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self fetchResultsController]; // this fetch to ensure the fetch result object is avail even after come back from the next screen
}


-(void) downloadAndSaveStatement:(NSManagedObjectContext *)context  withURLString:(NSString *) urlString 
{
   
    stmtGroupEntity= (StatementGroupEntity*)[NSEntityDescription insertNewObjectForEntityForName:kStatementGroupEntity 
                                                                  inManagedObjectContext:context]; 
    
   
    
     //   NSLog(PreviouslyLastSelectedBalanceRecordEntity.account);
    NSLog(urlString);
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease]; 
    [request setURL:[NSURL URLWithString:urlString]]; 
    [request setHTTPMethod:@"GET"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil]; 
    
    Statement* stmt = [[Statement alloc ] init];
    stmt = [Statement parseFromData:returnData];
    NSArray* records = stmt.recordsList;    
    for (id rec in records){
        StatementRecordEntity* recordEntity= (StatementRecordEntity*)[NSEntityDescription insertNewObjectForEntityForName:kStatementRecordEntity 
                                                                                 inManagedObjectContext:context]; 
        
        recordEntity.accumBal=[NSNumber numberWithLongLong:[(Record*)rec accumBal]];
        recordEntity.amount= [NSNumber numberWithLongLong:[(Record*)rec amount ]];
        recordEntity.account = [(Record*)rec account];
        recordEntity.book = [(Record*)rec book];
        recordEntity.narrative =[(Record*)rec narrative];
        recordEntity.timeStampInserted=  [NSNumber numberWithLongLong:[(Record*)rec timeStampInsert]];
        recordEntity.date = [DateTimeHelper convertNSNumberToDate:recordEntity.timeStampInserted withTime:FALSE];
        
        [stmtGroupEntity addRecordsObject:recordEntity ];
    }
    
    [context save:nil];

}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = [[fetchedResultsController sections] count];
    
	if (count == 0) {
		count = 1;
	}
	
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
	
    if ([[fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return numberOfRows;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* identifier = @"style-value2";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( nil == cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:identifier];
        [cell autorelease];
    }
    
    StatementRecordEntity* recordEntity =[fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = recordEntity.narrative;
    cell.detailTextLabel.text = [formatter stringFromNumber: recordEntity.amount];    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator   ;
    return cell;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section 
{
    return [[[fetchedResultsController sections] objectAtIndex:section] name];
}


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath 
{   
    
    AccountStatementTransactionController* addViewController = [[AccountStatementTransactionController alloc] initWithNibName:@"AccountStatementTransactionController" bundle:nil];   
    addViewController.previouslyObtainedFetchedResultsController = fetchedResultsController ;
    addViewController.lastSelectedIndexPath=indexPath;
    addViewController.title= @"Details";
   
    [self.navigationController pushViewController:addViewController animated:YES]; 
    [addViewController release];
     
}    


- (void) deleteAllObjects: (NSString *) entityDescription  {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    
    
    for (NSManagedObject *managedObject in items) {
        [self.managedObjectContext deleteObject:managedObject];
        NSLog(@"%@ object deleted",entityDescription);
    }
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
    }
    
}



@end
