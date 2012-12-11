//
//  UIPageFlowView.h
//  PageScrollFlowDemo
//
//  Created by demon on 12/10/12.
//  Copyright (c) 2012 NicoFun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    FlowHorizon,/**< 水平滚动 */
    FlowVertical/**< 垂直滚动 */
}FlowOritention;

@interface UIPageFlowView : UIScrollView<UIScrollViewDelegate>
{
    /**
     *	@brief	PageFlow中子试图Cell开始缩放的点
     */
     CGFloat _scalePoint;

}
-(id)initWithFrame:(CGRect)frame
          children:(NSArray*)children;
-(void)refresh;

/**
 *	@brief	选中试图的缩放倍数(>1)
 */
@property(nonatomic,assign) CGFloat scale;

/**
 *	@brief	子试图
 */
@property(nonatomic,retain) NSArray * children;

/**
 *	@brief	子试图cell的大小
 */
@property(nonatomic,assign) CGSize cellSize;

/**
 *	@brief	滚动方向，目前只支持水平滚动
 */
@property(nonatomic,assign) FlowOritention oretention;

/**
 *	@brief	当前选中(放大)的视图
 */
@property(nonatomic,retain) UIView * select_view;


@end
