//
//  FuzzyClock.m
//  FuzzyClock
//
//  Created by Charles Lehner on 2/12/11.
//  Copyright 2011 Charles Lehner. All rights reserved.
//

#import "FuzzyClock.h"
#import "FuzzyClockView.h"

@implementation FuzzyClock

- (id)initWithBundle:(NSBundle *)bundle
{
    self = [super initWithBundle:bundle];
    if(self == nil)
        return nil;
	
    // we will create and set the MenuExtraView
    theView = [[FuzzyClockView alloc] initWithFrame:
			   [[self view] frame] menuExtra:self];
    [self setView:theView];
	
	// init menu stuff
	theMenu = [[NSMenu alloc] initWithTitle: @""];
    
	clockMenuItem = [theMenu addItemWithTitle: @"00:00"
														 action: nil
												  keyEquivalent: @""];
	[clockMenuItem setEnabled:false];
    dateMenuItem = [theMenu addItemWithTitle:@"day, month ##, ####" action:nil keyEquivalent:@""];
    [dateMenuItem setEnabled:false];
	periodTitle = @"";
	
	[self setMenu:theMenu];
	[self setHighlightMode:YES];

	[self updateClock];
	
	timer = [[NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)1
											  target:self
											selector:@selector(_updateTimer:)
											userInfo:nil repeats:YES] retain];
	
	return self;
}

- (void)dealloc
{
    [theView release];
    [theMenu release];
	[timer release];
    [super dealloc];
}

- (NSString*)getDateText
{
    NSDate *now = [[NSDate alloc] init];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"EEEE, MMMM d, y"];
    return [formatter stringFromDate:now];
}

- (NSString*)getClockText
{
    NSDate *now = [[NSDate alloc] init];
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"h:mm:ss a"];
	return [formatter stringFromDate:now];
}

- (void)updateClock
{
	[theView setClockString:[self getFuzzyTime]];
    if ([self isMenuDown]) {
        [self updateMenu];
    }
}

- (void)_updateTimer:(NSTimer*)timer
{
    NSCalendarDate *now = [NSCalendarDate calendarDate];
    
    
    // Compute the current 30 seconds step of the current hour
    int step = [now minuteOfHour] * 2 + [now secondOfMinute] / 30;
    int nextState;
    
    // ...during the first minute we stick at the full hour
    if (step < 2)
        nextState = 0;
    
    // ...special state before the first full 5 minutes
    else if (2 <= step && step <= 5)
        nextState = 1;
    
    // ...rounding to full 5 minute steps
    else if (step < 116)
        nextState = 1 + ((step + 4) / 10);
    
    // ...round to full next hour
    else
        nextState = 13;
    
    
    // Add the current hour to the state
    nextState += [now hourOfDay] * 100;
    
    
    // Update if needed
    if (state != nextState)
    {
        state = nextState;
    }
    [self updateClock];
}

- (void)_menuClicked:(NSNotification *)notification
{
	[self updateTimeFormat];
    [self updateClock];
    [self updateMenu];
}

- (NSString *)getFuzzyTime
{
    NSCalendarDate *now = [NSCalendarDate calendarDate];
    int hour = [now hourOfDay];

    NSString *fuzzy_time;
    NSString *hour_name;
    NSString *formatting;
    
    if (state % 100 > 7) {
        hour++;
    }


    switch (hour) {
        case 0:
        case 24:
            hour_name = @"midnight";
            break;
        case 1:
        case 13:
            hour_name = @"one";
            break;
        case 2:
        case 14:
            hour_name = @"two";
            break;
        case 3:
        case 15:
            hour_name = @"three";
            break;
        case 4:
        case 16:
            hour_name = @"four";
            break;
        case 5:
        case 17:
            hour_name = @"five";
            break;
        case 6:
        case 18:
            hour_name = @"six";
            break;
        case 7:
        case 19:
            hour_name = @"seven";
            break;
        case 8:
        case 20:
            hour_name = @"eight";
            break;
        case 9:
        case 21:
            hour_name = @"nine";
            break;
        case 10:
        case 22:
            hour_name = @"ten";
            break;
        case 11:
        case 23:
            hour_name = @"eleven";
            break;
        case 12:
            hour_name = @"noon";
        default:
            break;
    }
    switch (state % 100) {
        case 0:
            formatting = @"%@ o'clock";
            break;
        case 1:
            formatting = @"shortly after %@";
            break;
        case 2:
            formatting = @"five past %@";
            break;
        case 3:
            formatting = @"ten past %@";
            break;
        case 4:
            formatting = @"quarter past %@";
            break;
        case 5:
            formatting = @"twenty past %@";
            break;
        case 6:
            formatting = @"twentyfive past %@";
            break;
        case 7:
            formatting = @"half past %@";
            break;
        case 8:
            formatting = @"twentyfive to %@";
            break;
        case 9:
            formatting = @"twenty to %@";
            break;
        case 10:
            formatting = @"quarter to %@";
            break;
        case 11:
            formatting = @"ten to %@";
            break;
        case 12:
            formatting = @"five to %@";
            break;
        case 13:
            formatting = @"nearly %@";
            break;
        default:
            formatting = @"???%@???";
            break;
    }
    
    fuzzy_time = [NSString stringWithFormat: formatting, hour_name];
    
    return fuzzy_time;
}

- (void)updateMenu
{
    [clockMenuItem setTitle:[self getClockText]];
    [dateMenuItem setTitle:[self getDateText]];
}

- (void)updateTimeFormat
{
	// if the normal clock menuextra shows seconds, we will too.
	id format = [(id)CFPreferencesCopyAppValue((CFStringRef)@"DateFormat", (CFStringRef)@"com.apple.menuextra.clock") autorelease];
	showSeconds = format == nil || [format rangeOfString:@":ss"].location != NSNotFound;
}
@end
