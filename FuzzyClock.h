//
//  FuzzyClock.h
//  FuzzyClock
//
//  Created by Charles Lehner on 2/12/11.
//  Copyright 2011 Charles Lehner. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSMenuExtra.h"
#import "NSMenuExtraView.h"
@class FuzzyClockView;


@interface FuzzyClock : NSMenuExtra {
	FuzzyClockView *theView;
	NSMenu *theMenu;
	NSTimer *timer;
	NSArray *periods;
	NSString* periodTitle;
	NSMenuItem* clockMenuItem;
    NSMenuItem* dateMenuItem;
	int period;
    int state;
	BOOL showSeconds;
}

- (NSString*)getClockText;
- (NSString*)getDateText;
- (void)updateClock;
- (void)_updateTimer:(NSTimer*)timer;
- (NSString*)getFuzzyTime;
- (void)_menuClicked:(NSNotification *)notification;
- (void)updateMenu;
- (void)updateTimeFormat;
@end
