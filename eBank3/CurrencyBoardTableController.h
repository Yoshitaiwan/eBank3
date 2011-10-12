//
//  CurrencyBoardTableController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 12/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyBoardTableController : UITableViewController
{
    @private    
    NSMutableArray* images_;
    NSDictionary* dataSource_;
}

@property(nonatomic,retain) NSMutableArray* images;

@end
