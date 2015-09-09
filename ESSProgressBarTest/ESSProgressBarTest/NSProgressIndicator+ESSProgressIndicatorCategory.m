//
//  NSProgressIndicator+ESSProgressIndicatorCategory.m
//  Briefly
//
//  Created by Matthias Gansrigler on 06.05.2015.
//  Copyright (c) 2015 Eternal Storms Software. All rights reserved.
//

#import "NSProgressIndicator+ESSProgressIndicatorCategory.h"

@interface ESSProgressBarAnimation : NSAnimation

@property (weak) NSProgressIndicator *progInd;
@property (assign) double initialValue;
@property (assign) double newValue;

- (instancetype)initWithProgressBar:(NSProgressIndicator *)ind
					 newDoubleValue:(double)val;

@end


@implementation NSProgressIndicator (ESSProgressIndicatorCategory)

static ESSProgressBarAnimation *anim = nil;
- (void)animateToDoubleValue:(double)val
{
	if (anim != nil)
	{
		double oldToValue = anim.newValue;
		[anim stopAnimation];
		anim = nil;
		self.doubleValue = oldToValue;
	}
	
	anim = [[ESSProgressBarAnimation alloc] initWithProgressBar:self
												 newDoubleValue:val];
	[anim startAnimation];
}

- (void)animationDealloc
{
	[anim stopAnimation];
	anim = nil;
}

@end


@implementation ESSProgressBarAnimation

- (instancetype)initWithProgressBar:(NSProgressIndicator *)ind
					 newDoubleValue:(double)val
{
	if (self = [super initWithDuration:0.15 animationCurve:NSAnimationLinear])
	{
		self.progInd = ind;
		self.initialValue = self.progInd.doubleValue;
		self.newValue = val;
		self.animationBlockingMode = NSAnimationNonblocking;
		return self;
	}
	
	return nil;
}

- (void)setCurrentProgress:(NSAnimationProgress)currentProgress
{
	[super setCurrentProgress:currentProgress];
	
	double delta = self.newValue-self.initialValue;
	
	self.progInd.doubleValue = self.initialValue + (delta* self.currentValue); //changed from currentProgress to currentValue to take into account animationCurves. Thanks, Alan B. for the tip
	
	if (currentProgress == 1.0 && [self.progInd respondsToSelector:@selector(animationDealloc)])
		[self.progInd animationDealloc];
}

@end