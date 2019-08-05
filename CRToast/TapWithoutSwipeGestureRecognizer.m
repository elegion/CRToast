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
        
    }
    return self;
}

- (void)reset
{
    [super reset];
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
    if ([self distance:currentTap andPoint:self.firstTap] > maxDistanceForSuccessTap) {
        self.state = UIGestureRecognizerStateFailed;
    } else {
        self.state = UIGestureRecognizerStateRecognized;
    }
    [self reset];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.state = UIGestureRecognizerStateCancelled;
    [self reset];
}

-(CGFloat)distance:(CGPoint) p1 andPoint:(CGPoint)p2 {
    CGFloat xDist = (p2.x - p1.x);
    CGFloat yDist = (p2.y - p1.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

@end
