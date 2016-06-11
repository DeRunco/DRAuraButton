
#import <UIKit/UIKit.h>
#import <DRAuraButton/DRAuraConfiguration.h>

@interface DRAuraCircle: UIView

@property (nonatomic, readonly)DRAuraConfiguration *config;

- (void)changeConfiguration:(DRAuraConfiguration*)tmpConfig;
- (void)commitConfiguration;

@end
