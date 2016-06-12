#import <UIKit/UIKit.h>
#import <DRAuraButton/DRAuraConfiguration.h>

/**
 *  This UIButton is the main public object of this framework. Upon initialization (storyboard or manual), it creates and adds a subview in which two arcs ars drawn.
 Note that thread safety was *not* a goal of this project. Calling addAuraConfiguration: or removeAuraConfiguration: carelessly will lead to unexpected behaviour.
 */
@interface DRAuraButton : UIButton

/**
 *  Adds a configuration. The ID field is mandatory for the configuration to be created. If the ID field is not filled, the configuration is not added.
 *
 *  @param block A builder for the configuration object.
 */
- (void)addAuraConfiguration:(void (^)(DRAuraConfiguration* c))block;

/**
 *  Remove a configuration from the available configurations.
 *
 *  @param ID The ID of the configuration to remove.
 */
- (void)removeAuraConfiguration:(NSObject *)ID;

/**
 *  A readonly list of the configurations.
 */
@property (nonatomic, readonly) NSDictionary <NSObject *, DRAuraConfiguration *> *auraConfigurations;

/**
 *  Return the ID of the currently used configuration.
 */
@property (nonatomic) NSObject *currentStateID;

@end