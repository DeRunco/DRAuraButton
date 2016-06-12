//
//  DRViewController.m
//  DRAuraButton
//
//  Created by Charles Thierry on 06/12/2016.
//  Copyright (c) 2016 Charles Thierry. All rights reserved.
//

#import "DRViewController.h"

@interface DRViewController ()
@property (nonatomic) NSInteger currentStep;
@end

NSString *stateForStep(NSInteger step)
{
	return @[@"idle", @"loading", @"playing", @"stopping"][step];
}

@implementation DRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self configureTheButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)step:(id)sender
{
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0L), ^{

		switch (_currentStep) {
			case 0:
				_currentStep = 1;
				break;
			case 1:
				_currentStep = 2;
				break;
			case 2:
				_currentStep = 3;
				break;
			case 3:
				_currentStep = 0;
				break;
		}
		[_button setCurrentStateID:stateForStep(_currentStep)];
	});
}

- (void)configureTheButton
{
	CGFloat auraWidth = 6.;
	CGFloat auraSpace = 0.;
	CGFloat auraSpacePlaying = 5.;
	CGFloat auraOffset = 6;
	
	[_button addAuraConfiguration:^(DRAuraConfiguration *c) {
		c.ID = stateForStep(0);
		c.width = auraWidth;
		c.space = auraSpace;
		c.offset = auraOffset;
		c.step = 0.;
		c.color = [UIColor blackColor];
	}];
	[_button addAuraConfiguration:^(DRAuraConfiguration *c) {
		c.ID = stateForStep(1);
		c.width = auraWidth;
		c.space = auraSpace;
		c.offset = auraOffset;
		c.step = 0.01;
		c.color = [UIColor redColor];
	}];
	[_button addAuraConfiguration:^(DRAuraConfiguration *c) {
		c.ID = stateForStep(2);
		c.width = auraWidth;
		c.space = auraSpacePlaying;
		c.offset = auraOffset;
		c.step = 0.02;
		c.color = [UIColor greenColor];
	}];
	[_button addAuraConfiguration:^(DRAuraConfiguration *c) {
		c.ID = stateForStep(3);
		c.width = auraWidth;
		c.space = auraSpace;
		c.offset = auraOffset;
		c.step = 0.01;
		c.color = [UIColor orangeColor];
	}];
	[_button setCurrentStateID:stateForStep(0)];
}

@end
