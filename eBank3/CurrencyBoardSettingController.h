//
//  CurrencyBoardSettingController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 2/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyBoardSettingController : UITableViewController
{
    
    
	UISwitch				*switchCtl;
	UISlider				*sliderCtl;
	NSArray					*dataSourceArray;
}

@property (nonatomic, retain, readonly) UISwitch *switchCtl;
@property (nonatomic, retain, readonly) UISlider *sliderCtl;
@property (nonatomic, retain) NSArray *dataSourceArray;

@end
