#import "DRAuraCircle.h"

NSArray<UIBezierPath *> *smallPath(CGRect frame, CGFloat width, CGFloat offset, CGFloat space)
{
	CGFloat radius = (frame.size.width - width)/2. + space;
	CGFloat angleOffset = offset / radius;
	
	UIBezierPath *pathBottom = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2., frame.size.height/2.)
															  radius:radius startAngle:angleOffset
															endAngle:M_PI-angleOffset
														   clockwise:YES];
	
	UIBezierPath *pathTop = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2., frame.size.height/2.)
														   radius:radius startAngle:-angleOffset
														 endAngle:-M_PI+angleOffset
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
	
	NSArray<UIBezierPath *>* paths = smallPath(self.bounds, _config.width, _config.offset, _config.space);
	
	_topLayer.path = paths[0].CGPath;
	_bottomLayer.path = paths[1].CGPath;
	
	_topLayer.lineWidth = _config.width;
	_bottomLayer.lineWidth = _config.width;
	
	_topLayer.lineCap = @"round";
	_bottomLayer.lineCap = @"round";
	
	_topLayer.strokeColor = _config.auraColor.CGColor;
	_bottomLayer.strokeColor = _config.auraColor.CGColor;
	
	_topLayer.fillColor = [UIColor clearColor].CGColor;
	_bottomLayer.fillColor = [UIColor clearColor].CGColor;
	
	self.superview.layer.backgroundColor = _config.buttonColor.CGColor;
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
	
	NSArray<UIBezierPath *>* smallpaths = smallPath(self.bounds, _tmpConfig.width, _tmpConfig.offset, _tmpConfig.space);
	
	CABasicAnimation *morphTop = [CABasicAnimation animationWithKeyPath:@"path"];
	morphTop.duration = _tmpConfig.animationDuration;
	morphTop.toValue = (__bridge id _Nullable)(smallpaths[0].CGPath);
	morphTop.fromValue = (__bridge id _Nullable)(_topLayer.path);
	
	CABasicAnimation *morphBottom = [CABasicAnimation animationWithKeyPath:@"path"];
	morphBottom.duration = _tmpConfig.animationDuration;
	morphBottom.toValue = (__bridge id _Nullable)smallpaths[1].CGPath;
	morphBottom.fromValue = (__bridge id _Nullable)(_bottomLayer.path);
	
	CABasicAnimation *colorTop = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
	colorTop.duration = _tmpConfig.animationDuration;
	colorTop.toValue = (__bridge id _Nullable)(_tmpConfig.auraColor.CGColor);
	colorTop.fromValue = (__bridge id _Nullable)(_config.auraColor.CGColor);
	
	CABasicAnimation *colorBottom = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
	colorBottom.duration = _tmpConfig.animationDuration;
	colorBottom.toValue = (__bridge id _Nullable)(_tmpConfig.auraColor.CGColor);
	colorBottom.fromValue = (__bridge id _Nullable)(_config.auraColor.CGColor);

	CABasicAnimation *colorSuperview = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
	colorSuperview.duration = _tmpConfig.animationDuration;
	colorSuperview.toValue = (__bridge id _Nullable)(_tmpConfig.buttonColor.CGColor);
	colorSuperview.fromValue = (__bridge id _Nullable)(_config.buttonColor.CGColor);
	
	[_topLayer addAnimation:morphTop forKey:nil];
	[_bottomLayer addAnimation:morphBottom forKey:nil];
	
	[_topLayer addAnimation:colorTop forKey:nil];
	[_bottomLayer addAnimation:colorBottom forKey:nil];
	
	[self.superview.layer addAnimation:colorSuperview forKey:nil];
	
	[CATransaction setDisableActions:YES];
	
	NSLog(@"UpdateContent: %@", NSStringFromCGRect(self.bounds));
	_config = _tmpConfig;
	[self applyCurrentConfiguration];
	
	
	[CATransaction setDisableActions:NO];
}

@end
