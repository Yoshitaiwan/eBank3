//
//  ExchangeMarketsController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeMarketsController : UIViewController  <UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate> 
{
    
	UIView* viewController1_;
    UIView* viewController2_;
    UIView* amountInputView_;
    
    UIBarButtonItem* toAmountButton_;
    UIBarButtonItem* toPayee_;
    UIButton* amountInputButton_;
    UIButton* fromInputButton_;
    
    BOOL transitioning;
    UIPickerView* sendTypePicker_;
    
    
    
	NSArray* dataSourceArray_;
    
}
@property (nonatomic, retain) IBOutlet UIView* viewController1;
@property (nonatomic, retain) IBOutlet UIView* viewController2;
@property(nonatomic,retain) IBOutlet UIBarButtonItem* toAmountButton;
@property(nonatomic,retain) IBOutlet UIBarButtonItem* toPayee;
@property(nonatomic,retain) IBOutlet UIView* amountInputView;
@property(nonatomic,retain) IBOutlet UIButton*  amountInputButton;
@property(nonatomic,retain) IBOutlet UIButton*  fromInputButton;

@property(nonatomic,retain) IBOutlet UIPickerView* sendTypePicker;

@property BOOL transitioning;
@property (nonatomic, retain) NSArray *dataSourceArray;


- (IBAction) toAmountButtonPressed: (id) sender;
- (IBAction) toPayeeButtonPressed: (id) sender;
- (IBAction) amountInputButtonPressed:(id)sender;

- (IBAction) fromInputButtonPressed:(id)sender;


@end
