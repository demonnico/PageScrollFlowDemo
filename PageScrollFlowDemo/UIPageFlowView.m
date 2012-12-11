//
//  UIPageFlowView.m
//  PageScrollFlowDemo
//
//  Created by demon on 12/10/12.
//  Copyright (c) 2012 NicoFun. All rights reserved.
//

#import "UIPageFlowView.h"

@implementation UIPageFlowView


@synthesize
select_view = _select_view,
children    = _children,
cellSize    = _cellSize,
scale       = _scale,
oretention  = _oretention;

-(id)initWithFrame:(CGRect)frame
          children:(NSArray*)children
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.children = children;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator   = NO;
        self.delegate =self;
        
        for (UIView * view in children)
        {
            [self addSubview:view];
            view.center  =CGPointMake(0, self.frame.size.height/2);
        }
        self.alwaysBounceHorizontal = YES;
        self.alwaysBounceVertical   = NO;
        
        
    }
    return self;
}

-(void)setCellSize:(CGSize)cellSize
{
    _cellSize   = cellSize;
    _scalePoint = cellSize.width;
    
    self.contentInset = UIEdgeInsetsMake(0,
                                         _scalePoint,
                                         0,
                                         self.frame.size.width-_scalePoint*2);
}

-(void)refresh
{
    int center_x = 0;
    switch (_oretention)
    {
        case FlowHorizon:
            for (UIView * view in _children)
            {
                center_x = center_x?center_x:_cellSize.width/2;
                view.center = CGPointMake(center_x, view.center.y);
                center_x+=_cellSize.width;
            }
            self.contentSize = CGSizeMake(_cellSize.width*([_children count]-1+_scale),
                                          _cellSize.height*_scale);
            break;
            
        case FlowVertical:
            break;
    }
       
    [self setContentOffset:CGPointMake(-_scalePoint/2, 0)];
    [self scrollViewDidScroll:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    switch (_oretention) {
        case FlowHorizon:
        {
            for (UIView * view in self.children)
            {
                CGFloat scale  = [self getScaleByCenter:view.center];
                [view setTransform:CGAffineTransformMakeScale(scale, scale)];
                //将当前选中项为Z轴最高层
                int viewIndex = [self.subviews indexOfObject:view];
                if(scale>1)
                {
                    self.select_view = view;
                    [self exchangeSubviewAtIndex:viewIndex
                              withSubviewAtIndex:[self.subviews count]-1];
                }
            }
            break;
        }
        case FlowVertical:
            break;
    }
    
   
}

-(CGFloat)getScaleByCenter:(CGPoint)center
{
    CGFloat scale = 1.0;
    switch (_oretention)
    {
        case FlowHorizon:
        {
            //重新计算某个Cell中心点相对在ScollView上的水平位置
            int offset_x =self.contentOffset.x;
            center.x-=offset_x;
            
            //水平x点与缩放基准点之间的距离
            int distance    = abs(center.x-_scalePoint);
            //缩放范围
            int scale_range = _cellSize.width*_scale/2;
           
            //进入缩放区域
            if(distance<scale_range)
                scale = _scale*(scale_range-distance)/scale_range;
            break;
        }
        case FlowVertical:
            break;
    }
    if(scale<1)
        scale = 1;
    return scale;
}



@end
