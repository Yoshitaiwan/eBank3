//
//  RootViewController.m
//  eBank2
//
//  Created by Yoshiyuki Matsuoka on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AccountListController.h"
#import "AccountStatementController.h"
#import "BalanceRecordEntity.h"
#import "Statement.pb.h"

#define kTagViewForTransition 1.0
#define kTransitionDuration   0.70
#define kAnimationDuration    1.00

#define kAccounts        @"My Accounts"
#define kMenu            @"Menu"

#define kBalanceRecordEntity   @"BalanceRecordEntity"
#define kBalanceGroupEntity    @"BalanceGroupEntity"

@implementation RootViewController

@synthesize amount_1 = amount_1_;
@synthesize accountDetailTopScreenView_1 = accountDetailView_1_;
@synthesize amount_2 = amount_2_;
@synthesize accountDetailTopScreenView_2= accountDetailView_2_;

@synthesize transitioning;
@synthesize editAccountButton=editAccountButton_;
@synthesize menuButton=menuButton_;

@synthesize containerView =containerView_;
@synthesize  myDataSource=myDataSource_;
@synthesize images = images_;

@synthesize fetchedResultsController,balanceGroupEntity,lastSelectedBalanceRecordEntity;
@synthesize managedObjectContext;

@synthesize formatter ;

- (void)dealloc
{
   [dataSourceImage_ release];
    
    
    [accountDetailView_1_ release];
    [accountDetailView_2_ release];
    [amount_1_ release];
    [amount_2_ release];
    
    [editAccountButton_ release];
    [menuButton_ release];
    
    [containerView_ release];
    [myDataSource_ release];
    
    [images_ release];

    [managedObjectContext release];
    [formatter release] ;   
    [lastSelectedBalanceRecordEntity release];
    [super dealloc];
    
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil context:(NSManagedObjectContext *) context
{
    if (self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
        self.managedObjectContext = context;
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.containerView addSubview:self.accountDetailTopScreenView_1];
    [self.containerView addSubview:self.accountDetailTopScreenView_2];
    
    self.accountDetailTopScreenView_1.hidden = NO;
    self.accountDetailTopScreenView_2.hidden = YES;
    self.transitioning = NO;
    
    self.navigationItem.title =kAccounts;
    self.navigationItem.leftBarButtonItem =self.menuButton;
    
    MenuController* menudata = [[MenuController alloc] init ];
    [menudata setMainViewContainer:self];
    myDataSource_ = menudata;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationItem.rightBarButtonItem = self.editAccountButton;
    [self downloadAndSaveStatement:self.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:kBalanceRecordEntity inManagedObjectContext:self.managedObjectContext];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"currency" ascending:YES]];
    request.predicate = nil;
    request.fetchBatchSize = 20;
    
    fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:request 
                                     managedObjectContext:managedObjectContext 
                                       sectionNameKeyPath:nil 
                                           cacheName:kBalanceRecordEntity];
    
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
    balanceGroupEntity= (StatementGroupEntity*)[NSEntityDescription insertNewObjectForEntityForName:kBalanceGroupEntity 
                                                                inManagedObjectContext:context]; 
    
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:8082/gb?account=Ac2"]; 
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease]; 
    [request setURL:[NSURL URLWithString:urlString]]; 
    [request setHTTPMethod:@"GET"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil]; 
    
    Statement* stmt = [[Statement alloc ] init];
    stmt = [Statement parseFromData:returnData];
    NSArray* records = stmt.recordsList;    
    for (id rec in records){
        BalanceRecordEntity* recordEntity= (BalanceRecordEntity*)[NSEntityDescription insertNewObjectForEntityForName:kBalanceRecordEntity
                                                                                 inManagedObjectContext:context]; 
        
        recordEntity.accumBal=[NSNumber numberWithLongLong:[(Record*)rec accumBal]];
        recordEntity.account = [(Record*)rec account];
        recordEntity.currency = [(Record*)rec currency];
        recordEntity.timeStampInserted=  [NSNumber numberWithLongLong:[(Record*)rec timeStampInsert]];
    
        [balanceGroupEntity addRecordsObject:recordEntity ];
    }
    
    [context save:nil];

}




#pragma mark -
#pragma mark Table view methods

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
    static NSString* identifier = @"basis-cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( nil == cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        [cell autorelease];
    }
 
    lastSelectedBalanceRecordEntity =[fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = lastSelectedBalanceRecordEntity.account;
  //  cell.imageView.image =  [[dataSourceImage_ objectForKey:key] objectAtIndex:indexPath.row];

    return cell;
}

/*
- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section 
{
    return [keys_ objectAtIndex:section];
}


- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView
{
    return keys_;
}
*/


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath 
{
    BalanceRecordEntity* record =[fetchedResultsController objectAtIndexPath:indexPath];
    self.amount_2.text = [formatter stringFromNumber: record.accumBal];    
    
    [self nextTransition];
}    


-(void)performTransition
{
   
	// First create a CATransition object to describe the transition
	CATransition *transition = [CATransition animation];
	// Animate over 3/4 of a second
	transition.duration = kTransitionDuration;
	// using the ease in/out timing function
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionMoveIn;
	transition.subtype = kCATransitionFromRight;
	// Finally, to avoid overlapping transitions we assign ourselves as the delegate for the animation and wait for the
	// -animationDidStop:finished: message. When it comes in, we will flag that we are no longer transitioning.
	transitioning = YES;
    transition.delegate = self;
	
	// Next add it to the containerView's layer. This will perform the transition based on how we change its contents.
	[self.containerView.layer addAnimation:transition forKey:nil];
	
	// Here we hide view1, and show view2, which will cause Core Animation to animate view1 away and view2 in.
	self.accountDetailTopScreenView_1.hidden = YES;
	self.accountDetailTopScreenView_2.hidden = NO;
	
	// And so that we will continue to swap between our two images, we swap the instance variables referencing them.
	UIView *tmp = self.accountDetailTopScreenView_2;
	self.accountDetailTopScreenView_2 = self.accountDetailTopScreenView_1;
	self.accountDetailTopScreenView_1 = tmp;
    
    UILabel *tmpLabel =self.amount_2;
    self.amount_2 = self.amount_1;
    self.amount_1 = tmpLabel;
    
}

-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
	self.transitioning = NO;
}

-(void)nextTransition 
{
	if(!self.transitioning)
	{
		[self performTransition];
	}
}

#pragma mark -
#pragma mark Actios

- (IBAction) editButtonPressed: (id) sender {
    UIViewController *addViewController = [[AccountListController alloc] initWithNibName:@"AccountListController" bundle:nil];
  	[self.navigationController pushViewController:addViewController animated:YES]; 
	[addViewController release];
}

- (IBAction) menuButtonPressed: (id) sender {
    UIView *nextView = [self nextView];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
    [UIView setAnimationDuration:kAnimationDuration];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES]; 
    [[self.view viewWithTag:kTagViewForTransition] removeFromSuperview];
    [self.view addSubview:nextView];
    [UIView commitAnimations];
    [UIView setAnimationsEnabled:NO];
}


-(IBAction)goToStatementLabelPressed :(id) sender{
    NSLog(@"go to statement pressed");

    AccountStatementController *addViewController = [[AccountStatementController alloc] initWithNibName:@"AccountStatementController" bundle:nil context:self.managedObjectContext];
    addViewController.PreviouslyLastSelectedBalanceRecordEntity =lastSelectedBalanceRecordEntity;
  	[self.navigationController pushViewController:addViewController animated:YES];
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
  	[addViewController release];

     
}

- (UIView*)nextView {
    UIView* view;
    UITableView *table ;
    if (  [self.navigationItem.title isEqualToString:kAccounts] ) {
        table = [[[UITableView alloc] init ]autorelease];
        table.dataSource = myDataSource_;
        table.delegate = myDataSource_;
        view = table;
        [self.navigationItem setTitle:kMenu]; 
        [self.navigationItem setRightBarButtonItem:nil animated:YES];
    } else {
        view = nil;
        self.navigationItem.title = kAccounts; 
        [self.navigationItem setRightBarButtonItem:editAccountButton_ animated:YES];
        
    }
    view.tag = kTagViewForTransition;
    view.frame = self.view.bounds;
    view.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.contentMode = UIViewContentModeScaleAspectFill;
    return view;
}

- (void)animationDidStop {
    [UIView setAnimationsEnabled:YES];
    
}

@end
