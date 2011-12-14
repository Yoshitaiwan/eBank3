//
//  BalanceGroupEntity.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 13/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
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
