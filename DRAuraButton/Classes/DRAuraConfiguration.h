
#import <UIKit/UIKit.h>

/**
 *  The configuration object is used to retain informations about the customization of the DRAuraButton and its DRAuraCircle.
 */
@interface DRAuraConfiguration: NSObject
/**
 *  The ID is used by the user to switch between configurations. No defaults. Must be set in the builder.
 */
@property (nonatomic, copy)NSString *ID;
/**
 *  The width of the stroke of the circle. Defaults to 1.0
 */
@property (nonatomic)CGFloat width;
/**
 *  The space between the button and the circle. Setting it to 0 brings a circle with a stroke of 0 pixel exactly inside the the sqare occupied by the button (or a (width, width) square).
 
 Defaults to 1.0. Greater is farther.
 */
@property (nonatomic)CGFloat space;
/**
 *  The offset is a percent of M_PI. It indicates the space between 0 radian and the beginning of the stroke.
 Defaults to 0.05
 */
@property (nonatomic)CGFloat offset;
/**
 *  The color of the circle stroke
 Defaults to black.
 */
@property (nonatomic)UIColor *auraColor;
/**
 *  The color of the button background layer
 Defaults to clear.
 */
@property (nonatomic)UIColor *buttonColor;
/**
 *  The rotation is done by NSTimer scheduled on the main thread, with a timeinterval of 0.025 (around 60fps). The step is the angle of progression during that time. It is in radian. If 0, no rotation happens.
 Defaults to 0.01
 */
@property (nonatomic)CGFloat step;

/**
 *  Indicate the time the transition to that configuration should take.
 Defaults to 0.25
 */
@property (nonatomic)CGFloat animationDuration;

@end
