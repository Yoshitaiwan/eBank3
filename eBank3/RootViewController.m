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
#import "RecordEntity.h"
#import "Statement.pb.h"

#define kTagViewForTransition 1.0
#define kTransitionDuration   0.70
#define kAnimationDuration    1.00

#define kAccounts        @"My Accounts"
#define kMenu            @"Menu"


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

@synthesize fetchedResultsController,stmtEntity;
@synthesize managedObjectContext;


- (void)dealloc
{
//    [keys_ release];
//    [dataSource_ release];
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
    
    [super dealloc];
    
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil context:(NSManagedObjectContext *) context
{
    if (self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
        self.managedObjectContext = context;
    return self;
}

/*
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    id  xxx =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!(self =xxx ))
        return nil;
    return self;   
}

*/

- (void)viewDidLoad
{
    [super viewDidLoad];
/*    
    NSError *error;
    
    
    NSMutableArray *test=  [managedObjectContext executeFetchRequest:request error:&error];
    //        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    
    [request release];
    
    self.fetchedResultsController = frc;
    [frc release];
    
    
    
    keys_ = [[NSArray alloc] initWithObjects:@"Singapore", @"U.K.", @"Malaysia", nil];
    NSArray* object1 = [NSArray arrayWithObjects:@"starbucks", @"daiso", @"fairprice" , nil];
    NSArray* object2 = [NSArray arrayWithObjects:@"amazon", @"facebook", nil];
    NSArray* object3 = [NSArray arrayWithObjects:@"Dog", @"Lion", nil];
    NSArray* objects = [NSArray arrayWithObjects:object1, object2, object3,  nil];
    dataSource_ = [[NSDictionary alloc] initWithObjects:objects forKeys:keys_];
    
    NSMutableArray*  imageTemp2 = [[NSMutableArray alloc ]  initWithCapacity:8];
    for (id key in keys_){
        NSMutableArray*  imageTemp = [[NSMutableArray alloc] init ];
        for (NSString* name in [dataSource_ objectForKey:key]){
            NSString* imageName = [NSString stringWithFormat:@"%@.png",name];
            UIImage* image = [UIImage imageNamed:imageName];
            [imageTemp addObject:image];
        }
        [imageTemp2 addObject:imageTemp];
        [imageTemp release];
    }
    
    dataSourceImage_ =  [[NSDictionary alloc] initWithObjects:imageTemp2 forKeys:keys_];
    [imageTemp2 release];
 */   

    
    
    
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
    
    //   	self.navigationItem.rightBarButtonItem = self.editAccountButton;
    [self downloadStatement:self.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"RecordEntity" inManagedObjectContext:self.managedObjectContext];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"currency" ascending:YES]];
    request.predicate = nil;
    request.fetchBatchSize = 20;
    
    fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:request 
                                     managedObjectContext:managedObjectContext 
                                       sectionNameKeyPath:nil 
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
    
}


-(void) downloadStatement:(NSManagedObjectContext *)context   
{
    stmtEntity= (StatementEntity*)[NSEntityDescription insertNewObjectForEntityForName:@"StatementEntity" 
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
        RecordEntity* recordEntity= (RecordEntity*)[NSEntityDescription insertNewObjectForEntityForName:@"RecordEntity" 
                                                                                 inManagedObjectContext:context]; 
        
        recordEntity.account = [(Record*)rec account]; 
        recordEntity.amount= [NSNumber numberWithUnsignedLongLong:[(Record*)rec amount ]];
        recordEntity.accumBal= [NSNumber numberWithUnsignedLongLong:[(Record*)rec accumBal ]];
        
        recordEntity.currency = [(Record*)rec currency];
        recordEntity.narrative =[(Record*)rec narrative];
        recordEntity.timeStampInserted=  [NSNumber numberWithUnsignedLongLong:[(Record*)rec timeStampInsert]];
        
        [stmtEntity addRecordsObject:recordEntity ];
        
        NSLog (@"%@", [NSString stringWithFormat:@"%d", [(Record*)rec accumBal ]]);
        NSLog (@"%@",[(Record*)rec account]);
        NSLog (@"%@",[(Record*)rec currency]);
        
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
 
    RecordEntity* text =[fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = text.account;
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
//    id key = [keys_ objectAtIndex:indexPath.section];
//    NSString* message  = [[dataSource_ objectForKey:key] objectAtIndex:indexPath.row];
  //  NSString *tmp = [message stringByAppendingString:@" current balance"] ;
 //   self.amount_2.text = tmp; 
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
    
    UIViewController *addViewController = [[AccountStatementController alloc] initWithNibName:@"AccountStatementController" bundle:nil];
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
