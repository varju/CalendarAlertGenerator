#import <EventKit/EventKit.h>

static int debugEventNum = 0;

%hook SBApplicationIcon

/*
// Hooking a class method
+ (id)sharedInstance {
return %orig;
}
*/

- (void)launch {
	%log;
	%orig;

	EKEventStore *eventStore = [[EKEventStore alloc] init];
	EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
	NSString *title = [NSString stringWithFormat:@"Test Alert %d", debugEventNum++];
	event.title     = title;
	
	NSDate *timeNow = [[NSDate alloc] init];
	event.startDate = [[NSDate alloc] initWithTimeInterval:65 sinceDate:timeNow];
	event.endDate   = [[NSDate alloc] initWithTimeInterval:60 sinceDate:event.startDate];
	
	EKAlarm *alarm1 = [EKAlarm alarmWithRelativeOffset:-60];
	NSMutableArray *myAlarmsArray = [[NSMutableArray alloc] init];
	[myAlarmsArray addObject:alarm1];
	event.alarms = myAlarmsArray;
	[myAlarmsArray release];
	
	[event setCalendar:[eventStore defaultCalendarForNewEvents]];

	NSError *err;
	[eventStore saveEvent:event span:EKSpanThisEvent error:&err];       
}

%end
