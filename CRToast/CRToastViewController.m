//
//  CRToast
//  Copyright (c) 2014-2015 Collin Ruffenach. All rights reserved.
//

#import "CRToastViewController.h"
#import "CRToast.h"
#import "CRToastLayoutHelpers.h"

#pragma mark - CRToastContainerView
@interface CRToastContainerView : UIView
@end

@implementation CRToastContainerView
@end

#pragma mark - CRToastViewController

@implementation CRToastViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _autorotate = YES;
    }
    return self;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark UIViewController

- (BOOL)shouldAutorotate {
    return _autorotate;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

- (void)loadView {
    self.view = [[CRToastContainerView alloc] init];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];

    if (self.toastView) {
        CGSize notificationSize = CRNotificationViewSizeForOrientation(self.notification.notificationType, self.notification.minimumHeight, toInterfaceOrientation);
        CGRect containerFrame = CGRectMake(0, 0, notificationSize.width, notificationSize.height);
        CGFloat topOffset;
        if (@available(iOS 11, *)) {
            topOffset = MAX(self.notification.containerTopOffset, CGRectGetMinY(self.view.superview.safeAreaLayoutGuide.layoutFrame) - 15 + self.notification.containerTopOffset);
        } else {
            topOffset = self.notification.containerTopOffset;
        }
        
        containerFrame = CRNotificationContainerAdjustedFrame(containerFrame, self.notification.maximumWidth, topOffset, self.notification.containerVerticalOffset);

        self.view.frame = containerFrame;
        self.toastView.frame = self.view.bounds;
    }
}

@end
