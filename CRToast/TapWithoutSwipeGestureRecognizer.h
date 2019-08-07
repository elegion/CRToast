//
//  TapWithoutSwipeGestureRecognizer.h
//  AppVersionMonitor
//
//  Created by Алексей Мошкин on 05/08/2019.
//

#import <UIKit/UIKit.h>

@interface TapWithoutSwipeGestureRecognizer : UIGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action;

@end
