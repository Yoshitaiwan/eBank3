//
//  RootViewController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 17/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController  <UITableViewDelegate,UITableViewDataSource,UINavigationBarDelegate,UIActionSheetDelegate>

{
@private
    NSArray* keys_;
    NSDictionary* dataSource_;
    
    
    UILabel *amount_1_;
    UIView  *accountDetailView_1_;
    UIView *containerView_;
    
    UILabel *amount_2_;
    UIView  *accountDetailView_2_;
    
    BOOL transitioning;
    
    // moved this UIBarButtonITem from MainWindow.xib to RootViewVController, as 
    // pushViewController cannot push on top of UIBarbuttonitem (UIView)
	UIBarButtonItem *addButton_;
    
    
}

@property(nonatomic,retain) IBOutlet UILabel *amount_1;
@property(nonatomic,retain) IBOutlet UIView  *accountDetailView_1;
@property(nonatomic,retain) IBOutlet UILabel *amount_2;
@property(nonatomic,retain) IBOutlet UIView  *accountDetailView_2;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;
//@property(nonatomic,retain) IBOutlet UIBarButtonItem * rightItem;

@property BOOL transitioning;

@property (nonatomic, retain) IBOutlet UIView *containerView;


- (IBAction) addButtonPressed: (id) sender;
@end
