//
//  BalanceGroupEntity.h
//  eBank4
//
//  Created by Yoshiyuki Matsuoka on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BalanceRecordEntity;

@interface BalanceGroupEntity : NSManagedObject

@property (nonatomic, retain) NSSet *records;
@end

@interface BalanceGroupEntity (CoreDataGeneratedAccessors)

- (void)addRecordsObject:(BalanceRecordEntity *)value;
- (void)removeRecordsObject:(BalanceRecordEntity *)value;
- (void)addRecords:(NSSet *)values;
- (void)removeRecords:(NSSet *)values;

@end
