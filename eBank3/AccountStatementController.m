//
//  AccountStatementController.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 25/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AccountStatementController.h"
#import "AccountStatementDetailController.h"
#import "Statement.pb.h"
#import "StatementEntity.h"
#import "RecordEntity.h"

@implementation AccountStatementController

@synthesize managedObjectContext, fetchedResultsController, formatter;

- (void)dealloc
{
    //   [keys_ release];
    //   [dataSource_ release];
    [managedObjectContext release];
    [fetchedResultsController release];
    [formatter release];
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
    
    self.navigationItem.title =@"Transactions";
    
    /*    keys_ = [[NSArray alloc] initWithObjects:@"21-Septempber-2011", @"01-October-2011", @"11-October-2011", @"21-October-2011", nil];
     NSArray* object1 = [NSArray arrayWithObjects:@"Pay to Thomas", @"From Ken by Transfer", @"From Tom by Bump", @"From Market ", nil];
     NSArray* object2 = [NSArray arrayWithObjects:@"Snake", @"Gecko", nil];
     NSArray* object3 = [NSArray arrayWithObjects:@"Frog", @"Newts", nil];
     NSArray* object4 = [NSArray arrayWithObjects:@"Shark", @"Salmon", nil];
     NSArray* objects = [NSArray arrayWithObjects:object1, object2, object3, object4, nil];
     dataSource_ = [[NSDictionary alloc] initWithObjects:objects forKeys:keys_];
     */    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self downloadAndSaveStatement:self.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"RecordEntity" inManagedObjectContext:self.managedObjectContext];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"currency" ascending:YES]];
    request.predicate = nil;
    request.fetchBatchSize = 20;
    
    fetchedResultsController = [[NSFetchedResultsController alloc]
                                initWithFetchRequest:request 
                                managedObjectContext:managedObjectContext 
                                sectionNameKeyPath:@"timeStampInserted" 
                                cacheName:@"MyStatementEntityCache"];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }		
    
    
    formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    
}


-(void) downloadAndSaveStatement:(NSManagedObjectContext *)context   
{
   
    stmtEntity= (StatementEntity*)[NSEntityDescription insertNewObjectForEntityForName:@"StatementEntity" 
                                                                  inManagedObjectContext:context]; 
    
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:8082/gs?account=Ac2"]; 
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease]; 
    [request setURL:[NSURL URLWithString:urlString]]; 
    [request setHTTPMethod:@"GET"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil]; 
    
    Statement* stmt = [[Statement alloc ] init];
    stmt = [Statement parseFromData:returnData];
    NSArray* records = stmt.recordsList;    
    for (id rec in records){
        RecordEntity* recordEntity= (RecordEntity*)[NSEntityDescription insertNewObjectForEntityForName:@"RecordEntity" 
                                                                                 inManagedObjectContext:context]; 
        
        recordEntity.accumBal=[NSNumber numberWithLongLong:[(Record*)rec accumBal]];
        recordEntity.amount= [NSNumber numberWithLongLong:[(Record*)rec amount ]];
        recordEntity.account = [(Record*)rec account];
        recordEntity.currency = [(Record*)rec currency];
        recordEntity.narrative =[(Record*)rec narrative];
        recordEntity.timeStampInserted=  [NSNumber numberWithLongLong:[(Record*)rec timeStampInsert]];
        
        [stmtEntity addRecordsObject:recordEntity ];
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
    
    RecordEntity* recordEntity =[fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = recordEntity.narrative;
    cell.detailTextLabel.text = [formatter stringFromNumber: recordEntity.amount];    
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator   ;
    return cell;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section 
{
//    NSLog([[[fetchedResultsController sections] objectAtIndex:section] name]);
    return [[[fetchedResultsController sections] objectAtIndex:section] name];
}


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath 
{
    /*   id key = [keys_ objectAtIndex:indexPath.section];
     NSString* message  = [[dataSource_ objectForKey:key] objectAtIndex:indexPath.row];
     
     UIViewController *addViewController = [[AccountStatementDetailController alloc] initWithNibName:@"AccountStatementDetailController" bundle:nil];
     addViewController.title= @"Details";
     [self.navigationController pushViewController:addViewController animated:YES]; 
     [addViewController release];
     
     */
}    





@end
