//
//  CurrencyBoardTableController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 16/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "CurrencyBoardCell.h"

@interface CurrencyBoardTableController : UITableViewController
{
@private
    NSDictionary* dataSource_;
    CurrencyBoardCell*  cellForCurrencyBoard_; 
    UIBarButtonItem* editButton_;
    
    
}
@property(nonatomic,retain) NSDictionary* datasource;
@property(nonatomic,retain) IBOutlet CurrencyBoardCell* cellForCurrencyBoard;
@property(nonatomic,retain)IBOutlet UIBarButtonItem *editButton;

@end
