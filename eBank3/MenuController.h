//
//  AccountMenuDataSource.h
//  eBank
//
//  Created by Yoshiyuki Matsuoka on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RootViewController;
@interface MenuController : NSObject<UITableViewDataSource>
{
    
@private
    NSArray* keys_;
    NSDictionary* dataSource_;
    UIViewController*  mainViewContainer_;  
    
    NSDictionary* dataSourceImage_;
    
}

@property(nonatomic,retain)  UIViewController* mainViewContainer;

@end

