//
//  RootViewController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 17/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "MenuController.h"


@interface RootViewController : UIViewController  <UITableViewDelegate,UITableViewDataSource>

{
@private
    NSArray* keys_;
    NSDictionary* dataSource_;
    
    
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

- (IBAction) editButtonPressed: (id) sender;
- (IBAction) menuButtonPressed: (id) sender;
- (IBAction) goToStatementLabelPressed: (id) sender;

-(UIView*)nextView;
-(void)nextTransition;

@end
