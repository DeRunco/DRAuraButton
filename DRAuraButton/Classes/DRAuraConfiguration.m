#import "DRAuraConfiguration.h"

@implementation DRAuraConfiguration
- (instancetype)init
{
	self = [super init];
	self.width = 1.;
	self.space = -1.;
	self.offset = 5;
	self.step = 0.01;
	self.auraColor = [UIColor blackColor];
	self.buttonColor = [UIColor clearColor];
	return self;
}

- (NSString *)debugDescription
{
	return [NSString stringWithFormat:@"<%@ %p> width %0.2f, space %0.2f, offset %0.2f, speed %0.2f, aura color %@, button color %@",
			[self class], self, self.width, self.space, self.offset, self.step, self.auraColor, self.buttonColor];
}

@end
