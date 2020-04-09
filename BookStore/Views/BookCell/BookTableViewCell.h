//
//  BookTableViewCell.h
//  BookStore
//
//  Created by Pedro Costa on 08/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookCoverImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imageLoadingActivityIndicator;

@end

NS_ASSUME_NONNULL_END
