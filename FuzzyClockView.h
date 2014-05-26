//
//  FuzzyClock.m
//  FuzzyClock
//
//  Created by Matthew West on 5/25/14.
//  Copyright 2014 Matthew West. All Rights Reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSMenuExtra.h"
#import "NSMenuExtraView.h"


@interface FuzzyClockView : NSMenuExtraView {
	NSString *clockString;
}

- (void)setClockString:(NSString*)str;

@end
