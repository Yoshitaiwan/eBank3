//
//  DateTimeHelper.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 24/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DateTimeHelper.h"

@implementation DateTimeHelper


+ (NSString* ) convertNSNumberToDate:(NSNumber*) nsNum  withTime:(BOOL) isTime;
{
    NSString* nsStr=   [nsNum stringValue];
    
    NSDateComponents* comps = [[[NSDateComponents alloc] init] autorelease];
    
    [comps setYear:[[nsStr substringWithRange:NSMakeRange(0,4)] integerValue]];
    [comps setMonth:[[nsStr substringWithRange:NSMakeRange(4,2)] integerValue]];
    [comps setDay:[[nsStr substringWithRange:NSMakeRange(6,2)] integerValue]];
    [comps setHour:[[nsStr substringWithRange:NSMakeRange(8,2)] integerValue]];
    [comps setMinute:[[nsStr substringWithRange:NSMakeRange(10,2)] integerValue]];
    [comps setSecond:[[nsStr substringWithRange:NSMakeRange(12,2)] integerValue]];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSTimeZone* timeZone=[NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    [calendar setTimeZone:timeZone];
    NSDate* date = [calendar dateFromComponents:comps];
   
    NSDateFormatter* dateFormatter= [[[NSDateFormatter alloc ] init] autorelease];
    [dateFormatter setTimeZone:[calendar timeZone]];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    
    if (isTime) {
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    }else{
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
    
     NSLog(@"dateFormatter=%@",date);
     return [dateFormatter stringFromDate:date];
}

@end
