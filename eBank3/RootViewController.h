//
//  RootViewController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 17/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MenuController.h"
#import "StatementEntity.h"


@interface RootViewController : UIViewController  <UITableViewDelegate,UITableViewDataSource>

{
@private
 // NSArray* keys_;
 //   NSDictionary* dataSource_;
   
    NSDictionary* dataSourceImage_;
    
    UILabel *amount_1_;
    UIView  *accountDetailView_1_;
    UIView *containerView_;
    UILabel *amount_2_;
    UIView  *accountDetailView_2_;
    
    NSMutableArray* images_;

    
    BOOL transitioning;
  
	UIBarButtonItem *editAccountButton_;
    UIBarButtonItem *menuButton_;
    
    MenuController *myDataSource_; 

    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;

    StatementEntity* stmtEntity ; 
    
    NSNumberFormatter* formatter;
}

@property(nonatomic,retain) IBOutlet UILabel *amount_1;
@property(nonatomic,retain) IBOutlet UIView  *accountDetailTopScreenView_1;
@property(nonatomic,retain) IBOutlet UILabel *amount_2;
@property(nonatomic,retain) IBOutlet UIView  *accountDetailTopScreenView_2;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *editAccountButton;
@property(nonatomic,retain) IBOutlet UIBarButtonItem *menuButton;

@property BOOL transitioning;

@property (nonatomic, retain) IBOutlet UIView *containerView;
@property (nonatomic,retain) MenuController *myDataSource;
@property (nonatomic,retain) NSMutableArray* images;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) StatementEntity* stmtEntity ;
@property (nonatomic, retain) NSNumberFormatter*  formatter;

- (IBAction) editButtonPressed: (id) sender;
- (IBAction) menuButtonPressed: (id) sender;
- (IBAction) goToStatementLabelPressed: (id) sender;

-(UIView*)nextView;
-(void)nextTransition;
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil context:(NSManagedObjectContext *) context;
-(void) downloadAndSaveStatement:(NSManagedObjectContext *)context   ;

@end
