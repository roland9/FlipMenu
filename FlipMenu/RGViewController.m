//
//  RGViewController.m
//  FlipMenu
//
//  Created by RolandG on 17/11/2013.
//  Copyright (c) 2013 mapps. All rights reserved.
//

#import "RGViewController.h"
#import "RGMenuView.h"

@interface RGViewController ()

@end

@interface RGViewController ()
@property (nonatomic, strong) RGMenuView *menu1;
@end


@implementation RGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _menu1= [[RGMenuView alloc] initWithFrame:CGRectMake(100, 100, 200, 200) foregroundText:@"Menu Help" backgroundText:@"Next Menu" foregroundMenuBlock:^{
        NSLog(@"foreground selected");
    } backgroundMenuBlock:^{
        NSLog(@"background selected");
    }];
    
    
    [self.view addSubview:_menu1];
}

@end