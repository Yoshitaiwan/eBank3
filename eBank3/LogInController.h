//
//  LogInController.h
//  eBank4
//
//  Created by Yoshiyuki Matsuoka on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInController : UITableViewController
{

@private
NSArray* keys_;
 UIView *footerView;

}


-(void) logInClickedAction:(id)sender;
@end
