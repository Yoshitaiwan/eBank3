//
//  main.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 17/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"eBank3AppDelegate");
   
  //  int retVal = UIApplicationMain(argc, argv, nil, nil);
    
    [pool release];
    return retVal;
}
