//
//  AppDelegate.m
//  ESSProgressBarTest
//
//  Created by Matthias Gansrigler on 06.05.2015.
//  Copyright (c) 2015 Eternal Storms Software. All rights reserved.
//

#import "AppDelegate.h"
#import "NSProgressIndicator+ESSProgressIndicatorCategory.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSProgressIndicator *indicator;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self increaseByTen];
	});
}

- (void)increaseByTen
{
	[self.indicator animateToDoubleValue:self.indicator.doubleValue+500];
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		if (self.indicator.doubleValue >= 1000.0)
			[self decreaseByTen];
		else
			[self increaseByTen];
	});
}

- (void)decreaseByTen
{
	[self.indicator animateToDoubleValue:self.indicator.doubleValue-500];
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		if (self.indicator.doubleValue <= 0.0)
			[self increaseByTen];
		else
			[self decreaseByTen];
	});
}

@end
