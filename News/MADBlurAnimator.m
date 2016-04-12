//
//  MADBlurAnimator.m
//  News
//
//  Created by Mariia Cherniuk on 11.04.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADBlurAnimator.h"

@implementation MADBlurAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 2.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForVC = [transitionContext finalFrameForViewController:toViewController];
    UIView *containerView = [transitionContext containerView];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    UIView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    
    blurView.translatesAutoresizingMaskIntoConstraints = NO;
    toViewController.view.bounds = CGRectOffset(finalFrameForVC, 0.f, bounds.size.height);
    toViewController.view.alpha = 0.f;
    toViewController.view.backgroundColor = [UIColor clearColor];
    toViewController.view.frame = finalFrameForVC;
    [containerView addSubview:fromViewController.view];
    [containerView addSubview:blurView];
    [containerView addSubview:toViewController.view];
    [self addConstraintsToSourceView:containerView targetView:blurView];
    [UIView animateWithDuration:1
                     animations:^{
                        toViewController.view.alpha = 1.f;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)addConstraintsToSourceView:(UIView *)sourceView targetView:(UIView *)targetView {
    [sourceView addConstraint:[NSLayoutConstraint constraintWithItem:targetView
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:sourceView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.f
                                                            constant:0.f]];
    
    [sourceView addConstraint:[NSLayoutConstraint constraintWithItem:targetView
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:sourceView
                                                           attribute:NSLayoutAttributeTrailing
                                                          multiplier:1.f
                                                            constant:0.f]];
    
    [sourceView addConstraint:[NSLayoutConstraint constraintWithItem:targetView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:sourceView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.f
                                                            constant:0.f]];
    
    [sourceView addConstraint:[NSLayoutConstraint constraintWithItem:targetView
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:sourceView
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.f
                                                            constant:0.f]];
}

@end
