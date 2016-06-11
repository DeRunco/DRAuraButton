#import <UIKit/UIKit.h>
#import <DRAuraButton/DRAuraConfiguration.h>

@interface DRAuraButton : UIButton
- (void)addAuraConfigurations:(void (^)(DRAuraConfiguration* c))block;
@property (nonatomic, readonly) NSDictionary <NSObject *, DRAuraConfiguration *> *auraConfigurations;
@property (nonatomic) NSObject *currentState;

@end