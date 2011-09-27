//
//  AccountMenuDataSource.h
//  eBank
//
//  Created by Yoshiyuki Matsuoka on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface MenuController : NSObject<UITableViewDataSource>
//@interface MenuController : UIViewController<UITableViewDataSource>
@interface MenuController : UITableViewController{
    @private
    NSArray* keys_;
    NSDictionary* dataSource_;
    
}

@end
