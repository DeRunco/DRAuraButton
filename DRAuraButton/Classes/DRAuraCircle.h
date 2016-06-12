
#import <UIKit/UIKit.h>
#import <DRAuraButton/DRAuraButton.h>

/**
 *  This UIView is added as a subview of the DRAuraButton on initialization. There should not be any need for the developer to come here.
 */
@interface DRAuraCircle: UIView
/**
 *  The current circle configuration
 */
@property (nonatomic, readonly)DRAuraConfiguration *config;

/**
 *  Calling this method does not actually change the circle. You need to call commitConfiguration for anything to happen.
 *
 *  @param tmpConfig The new configuration that will be used on commit.
 */
- (void)changeConfiguration:(DRAuraConfiguration*)tmpConfig;

/**
 *  You must call this method after calling `changeConfiguration:`
 */
- (void)commitConfiguration;

@end
