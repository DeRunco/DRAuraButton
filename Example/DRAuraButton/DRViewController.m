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
@property (nonatomic) NSTimer *pulseTimer;
@end

NSString *stateForStep(NSInteger step)
{
	return @[@"idle", @"loading"][step];
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

		switch (self.currentStep) {
			case 0:
				self.currentStep = 1;
				break;
			case 1:
				self.currentStep = 0;
				break;
		}
		[self.button setCurrentStateID:stateForStep(self.currentStep)];
	});
}

- (void)configureTheButton
{
	DRAuraButton *button = self.button;
	[button addAuraConfiguration:^(DRAuraConfiguration *c) {
		c.ID = stateForStep(0);
		c.width = 2.;
		c.space = 7.;
		c.offset = 4.;
		c.step = 0.04;
		c.animationDuration = 0.3;
		c.auraColor = [UIColor blackColor];
		c.buttonColor = [UIColor grayColor];
	}];
	[button addAuraConfiguration:^(DRAuraConfiguration *c) {
		c.ID = stateForStep(1);
		c.width = 25.;
		c.space = 30.5;
		c.offset = 16.;
		c.step = 0.07;
		c.animationDuration = 0.3;
		c.auraColor = [UIColor redColor];
		c.buttonColor = [UIColor orangeColor];
	}];
	[button setCurrentStateID:stateForStep(0)];
}


- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	_pulseTimer = [NSTimer scheduledTimerWithTimeInterval:5.1 target:self selector:@selector(changeMode:) userInfo:nil repeats:YES];
}


- (void)changeMode:(NSTimer *)t
{
	[self step:nil];	
}


@end
