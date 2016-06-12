#import "DRAuraCircle.h"

NSArray<UIBezierPath *> *smallPath(CGRect frame, CGFloat width, CGFloat offset, CGFloat space)
{
	UIBezierPath *pathBottom = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2., frame.size.height/2.)
															  radius:(frame.size.width - width)/2. - space startAngle:offset
															endAngle:M_PI-offset
														   clockwise:YES];
	
	UIBezierPath *pathTop = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2., frame.size.height/2.)
														   radius:(frame.size.width - width)/2. - space startAngle:-offset
														 endAngle:-M_PI+offset
														clockwise:NO];
	
	return @[pathTop, pathBottom];
}

@interface DRAuraCircle ()
@property (nonatomic) DRAuraConfiguration *tmpConfig;
@property (nonatomic) DRAuraConfiguration *config;
@property (nonatomic) CAShapeLayer *topLayer;
@property (nonatomic) CAShapeLayer *bottomLayer;

@end

@implementation DRAuraCircle

- (instancetype)init
{
	self = [super init];
	[self initBase];
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	[self initBase];
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	[self initBase];
	return self;
}

- (void)initBase
{
	self.userInteractionEnabled = NO;
	_topLayer = [CAShapeLayer layer];
	_bottomLayer = [CAShapeLayer layer];
	[self.layer addSublayer:_topLayer];
	[self.layer addSublayer:_bottomLayer];
	_config = [[DRAuraConfiguration alloc] init];
	[self applyCurrentConfiguration];
}

- (void)setFrame:(CGRect)frame
{
	//get the center
	[super setFrame:frame];
	self.layer.cornerRadius = self.frame.size.width/2.;
	self.backgroundColor = [UIColor clearColor];
	[self applyCurrentConfiguration];
}

- (void)applyCurrentConfiguration
{
	if (![NSThread isMainThread]) {
		NSLog(@"%s must be called from the main thread.", __FUNCTION__);
	}
	CGFloat offset = M_PI*_config.offset;
	NSArray<UIBezierPath *>* paths = smallPath(self.bounds, _config.width, offset, _config.space);
	
	_topLayer.path = paths[0].CGPath;
	_bottomLayer.path = paths[1].CGPath;
	
	_topLayer.lineWidth = _config.width;
	_bottomLayer.lineWidth = _config.width;
	
	_topLayer.lineCap = @"round";
	_bottomLayer.lineCap = @"round";
	
	_topLayer.strokeColor = _config.color.CGColor;
	_bottomLayer.strokeColor = _config.color.CGColor;
	
	_topLayer.fillColor = [UIColor clearColor].CGColor;
	_bottomLayer.fillColor = [UIColor clearColor].CGColor;
}

- (void)changeConfiguration:(DRAuraConfiguration*)tmpConfig;
{
	_tmpConfig = tmpConfig;
}

- (void)commitConfiguration
{
	if (![NSThread isMainThread]) {
		NSLog(@"%s must be called from the main thread.", __FUNCTION__);
		return;
	}
	
	if (CGRectEqualToRect(self.bounds, CGRectZero)) {
		return;
	}
	
	NSArray<UIBezierPath *>* smallpaths = smallPath(self.bounds, _tmpConfig.width, M_PI*_tmpConfig.offset/2., _tmpConfig.space);
	
	CABasicAnimation *morphTop = [CABasicAnimation animationWithKeyPath:@"path"];
	morphTop.duration = .3;
	morphTop.toValue = (__bridge id _Nullable)(smallpaths[0].CGPath);
	morphTop.fromValue = (__bridge id _Nullable)(_topLayer.path);
	
	CABasicAnimation *morphBottom = [CABasicAnimation animationWithKeyPath:@"path"];
	morphBottom.duration = .3;
	morphBottom.toValue = (__bridge id _Nullable)smallpaths[1].CGPath;
	morphBottom.fromValue = (__bridge id _Nullable)(_bottomLayer.path);
	
	CABasicAnimation *colorTop = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
	colorTop.duration = .3;
	colorTop.toValue = (__bridge id _Nullable)(_tmpConfig.color.CGColor);
	colorTop.fromValue = (__bridge id _Nullable)(_config.color.CGColor);
	
	CABasicAnimation *colorBottom = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
	colorBottom.duration = .3;
	colorBottom.toValue = (__bridge id _Nullable)(_tmpConfig.color.CGColor);
	colorBottom.fromValue = (__bridge id _Nullable)(_config.color.CGColor);

	[_topLayer addAnimation:morphTop forKey:nil];
	[_bottomLayer addAnimation:morphBottom forKey:nil];
	
	[_topLayer addAnimation:colorTop forKey:nil];
	[_bottomLayer addAnimation:colorBottom forKey:nil];
	
	[CATransaction setDisableActions:YES];
	
	NSLog(@"UpdateContent: %@", NSStringFromCGRect(self.bounds));
	_config = _tmpConfig;
	[self applyCurrentConfiguration];
	
	
	[CATransaction setDisableActions:NO];
}

@end
