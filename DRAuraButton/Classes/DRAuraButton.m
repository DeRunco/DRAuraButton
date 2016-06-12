#import <QuartzCore/QuartzCore.h>
#import "DRAuraButton.h"
#import "DRAuraCircle.h"

@interface DRAuraButton ()

@property (nonatomic) BOOL rotating;
@property (nonatomic) DRAuraCircle *aura;
@property (nonatomic) NSMutableDictionary <NSString *, DRAuraConfiguration *> *auraConfigurations;

@property (nonatomic) NSTimer *rotationTimer;
//TODO: get the angle from the aura transform to remove _rotationAngle?
@property (nonatomic) CGFloat rotationAngle;
@end

/**
 *  The four states of the button are as follows:
 - Idle: active, not higlighted
 - Loading: disabled, not highlighted
 - Playing: active, highlighted
 - Playing: disabled, highlighted (?? check if a button can be highlighted and disabled)
 */
@implementation DRAuraButton

- (instancetype)init
{
	self = [super init];
	[self initButton];
	[self initAura];
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	[self initButton];
	[self initAura];
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	[self initButton];
	[self initAura];
	return self;
}

- (void)initButton
{
	dispatch_async(dispatch_get_main_queue(), ^{
		self.layer.cornerRadius = self.frame.size.width / 2;
	});
}

- (void)initAura
{
	dispatch_async(dispatch_get_main_queue(), ^{
		_rotationAngle = - M_PI;
		_aura = [[DRAuraCircle alloc] initWithFrame:self.bounds];
		_aura.transform = CGAffineTransformMakeRotation(_rotationAngle);
		[self setNeedsLayout];
		[self addSubview:_aura];
		[self sendSubviewToBack:_aura];
		[self layoutIfNeeded];
	});
}

- (void)setCurrentStateID:(NSObject *)cS
{
	
	dispatch_async(dispatch_get_main_queue(), ^{
		DRAuraConfiguration *cf = _auraConfigurations[cS];
		[self startRotation];
		[self.aura changeConfiguration:cf];
		[self.aura commitConfiguration];
		_currentStateID= cS;
	});
}

//MARK: Aura rotation animation

- (void)startRotation
{
	NSTimer *timer = [NSTimer timerWithTimeInterval:0.016 target:self selector:@selector(rotateAura:) userInfo:nil repeats:YES];
	[_rotationTimer invalidate];
	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	_rotationTimer = timer;
	
}

- (void)suspendRotation
{
	[_rotationTimer invalidate];
	_rotationTimer = nil;
}

- (void)resetRotation
{
	_rotationAngle = _rotationAngle > 0 ? 0 : -M_PI;
	if (!_rotationTimer) {
		[UIView animateWithDuration:0.25 animations:^{
			_aura.transform = CGAffineTransformMakeRotation(_rotationAngle);
		}];
	}
}

- (void)rotateAura:(NSTimer *)timer
{
	DRAuraConfiguration *cf = _auraConfigurations[_currentStateID];
	if (cf.step != 0.0) {
		_aura.transform = CGAffineTransformMakeRotation(_rotationAngle);
		_rotationAngle += cf.step;
		if (_rotationAngle >= M_PI) {
			_rotationAngle -= 2*M_PI;
		}
	} else {
		[self suspendRotation];
		[self resetRotation];
	}
}

//MARK: Aura external configuration override

- (void)addAuraConfiguration:(void(^)(DRAuraConfiguration* c))block
{
	DRAuraConfiguration *conf = [[DRAuraConfiguration alloc] init];
	block(conf);
	if (conf.ID == nil) {
		NSLog(@"%s this configuration is lacking a valid ID -- it was not added.", __FUNCTION__);
		return;
	}
	if (!_auraConfigurations) {
		_auraConfigurations = [[NSMutableDictionary alloc] init];
	}
	[_auraConfigurations setObject:conf forKey:conf.ID];
}

- (void)removeAuraConfiguration:(NSString *)ID;
{
	DRAuraConfiguration *toRemove;
	toRemove = self.auraConfigurations[ID];
	if (!toRemove) {
		NSLog(@"%s No configuration with ID: %@", __FUNCTION__, ID);
		return;
	}
	[_auraConfigurations removeObjectForKey:toRemove];
}

@end
