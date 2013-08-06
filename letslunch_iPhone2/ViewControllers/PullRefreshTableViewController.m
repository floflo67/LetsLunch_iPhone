//
//  PullRefreshTableViewController.m
//  letslunch_iPhone2
//
//  Created by Florian Reiss on 31/07/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "PullRefreshTableViewController.h"

#define REFRESH_HEADER_HEIGHT 52.0f

@interface PullRefreshTableViewController()
@property (nonatomic, strong) UIView *refreshHeaderView;
@property (nonatomic, strong) UILabel *refreshLabel;
@property (nonatomic, strong) UIImageView *refreshArrow;
@property (nonatomic, strong) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic) BOOL isDragging;
@property (nonatomic) BOOL isLoading;

@property (nonatomic, strong, readwrite) NSString *textPull;
@property (nonatomic, strong, readwrite) NSString *textRelease;
@property (nonatomic, strong, readwrite) NSString *textLoading;
@end

@implementation PullRefreshTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self addPullToRefreshHeader];
}

-(void)setTextLoading:(NSString *)textLoading textRelease:(NSString*)textRelease andTextPull:(NSString *)textPull
{
    self.textLoading = textLoading;
    self.textPull = textPull;
    self.textRelease = textRelease;
}

- (void)addPullToRefreshHeader
{
    self.refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    self.refreshHeaderView.backgroundColor = [UIColor clearColor];

    self.refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
    self.refreshLabel.backgroundColor = [UIColor clearColor];
    self.refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    self.refreshLabel.textAlignment = NSTextAlignmentCenter;

    self.refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    self.refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                    27, 44);

    self.refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    self.refreshSpinner.hidesWhenStopped = YES;

    [self.refreshHeaderView addSubview:self.refreshLabel];
    [self.refreshHeaderView addSubview:self.refreshArrow];
    [self.refreshHeaderView addSubview:self.refreshSpinner];
    [self.tableView addSubview:self.refreshHeaderView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.isLoading) return;
    self.isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            self.tableView.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            self.tableView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (self.isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.25 animations:^{
            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
                // User is scrolling above the header
                self.refreshLabel.text = self.textRelease;
                [self.refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } else { 
                // User is scrolling somewhere within the header
                self.refreshLabel.text = self.textPull;
                [self.refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
        }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.isLoading) return;
    self.isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self startLoading];
    }
}

- (void)startLoading
{
    self.isLoading = YES;
    
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        self.refreshLabel.text = self.textLoading;
        self.refreshArrow.hidden = YES;
        [self.refreshSpinner startAnimating];
    }];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading
{
    self.isLoading = NO;
    
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsZero;
        [self.refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    } 
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}

- (void)stopLoadingComplete
{
    // Reset the header
    self.refreshLabel.text = self.textPull;
    self.refreshArrow.hidden = NO;
    [self.refreshSpinner stopAnimating];
}

- (void)refresh
{
    // This is just a demo. Override this method with your custom reload action.
    // Don't forget to call stopLoading at the end.
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
}

@end
