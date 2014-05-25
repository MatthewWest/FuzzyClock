//
//  FuzzyClockView.h
//  FuzzyClock
//
//  Created by Charles Lehner on 2/12/11.
//  Copyright 2011 Charles Lehner. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSMenuExtra.h"
#import "NSMenuExtraView.h"


@interface FuzzyClockView : NSMenuExtraView {
	NSString *clockString;
}

- (void)setClockString:(NSString*)str;

@end
