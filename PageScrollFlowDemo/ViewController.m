//
//  ViewController.m
//  PageScrollFlowDemo
//
//  Created by demon on 12/10/12.
//  Copyright (c) 2012 NicoFun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray * views = [NSMutableArray array];
    for (int i=0; i<7; i++)
    {
        NSString * imageName = [NSString stringWithFormat:@"%d.tiff",i];
        UIImage * image  = [UIImage imageNamed:imageName];
        UIImageView * iv = [[UIImageView alloc] initWithImage:image];
        [views addObject:iv];
        iv.frame = CGRectMake(0, 0, 100, 75);
        [iv release];
    }
    
    UILabel * lb_point = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 3, 20)];
    lb_point.backgroundColor = [UIColor greenColor];
    [self.view addSubview:lb_point];
    [lb_point release];
    
    UIPageFlowView * view = [[UIPageFlowView alloc] initWithFrame:CGRectMake(0,
                                                                             20,
                                                                             400,
                                                                             150)
                                                         children:views];
    view.scale      = 1.8;
    view.cellSize   = CGSizeMake(100, 75);
    view.oretention = FlowHorizon;
    [view refresh];
    [self.view addSubview:view];
    [view release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
