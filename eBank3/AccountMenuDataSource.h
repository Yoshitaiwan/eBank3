//
//  AccountMenuDataSource.h
//  eBank
//
//  Created by Yoshiyuki Matsuoka on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountMenuDataSource : NSObject<UITableViewDataSource>

{
    @private
    NSArray* keys_;
    NSDictionary* dataSource_;
    
    
    
}

@end
