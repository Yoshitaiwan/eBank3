//
//  AccountStatementController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 25/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountStatementController : UITableViewController
{
@private 
    NSArray* details_;    
    NSArray* keys_;
    NSDictionary* dataSource_;
}
@end
