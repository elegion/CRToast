//
//  TapWithoutSwipeGestureRecognizer.m
//  AppVersionMonitor
//
//  Created by Алексей Мошкин on 05/08/2019.
//

#import "TapWithoutSwipeGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>


@interface TapWithoutSwipeGestureRecognizer ()

@property (nonatomic)CGPoint firstTap;

@end

@implementation TapWithoutSwipeGestureRecognizer : UIGestureRecognizer

-(id)initWithTarget:(id)target action:(SEL)action{
    if ((self = [super initWithTarget:target action:action])){
        self.firstTap = CGPointMake(-1, -1);
    }
    return self;
}

- (void)reset
{
    [super reset];
    self.firstTap = CGPointMake(-1, -1);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (touches.count > 1)
    {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    self.firstTap = [touches.anyObject locationInView:self.view.superview];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];

    CGPoint currentTap = [touches.anyObject locationInView:self.view.superview];
   
    CGFloat maxDistanceForSuccessTap = 10;
    BOOL maxDistanceValidation = [self distance:currentTap andPoint:self.firstTap] < maxDistanceForSuccessTap;
    BOOL isCurrentTapCorrect = (currentTap.x >=0 && currentTap.y >= 0);
    if (maxDistanceValidation && isCurrentTapCorrect) {
        self.state = UIGestureRecognizerStateRecognized;
    } else {
        self.state = UIGestureRecognizerStateFailed;
    }
}

-(CGFloat)distance:(CGPoint) p1 andPoint:(CGPoint)p2 {
    CGFloat xDist = (p2.x - p1.x);
    CGFloat yDist = (p2.y - p1.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

@end
