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
@class FuzzyClockView;


@interface FuzzyClock : NSMenuExtra {
	FuzzyClockView *theView;
	NSMenu *theMenu;
	NSTimer *timer;
	NSMenuItem* clockMenuItem;
    NSMenuItem* dateMenuItem;
    int state;
	BOOL showSeconds;
}

- (NSString*)getClockText;
- (NSString*)getDateText;
- (void)updateClock:(Boolean)update;
- (void)_updateTimer:(NSTimer*)timer;
- (NSString*)getFuzzyTime;
- (void)_menuClicked:(NSNotification *)notification;
- (void)updateMenu;
@end
