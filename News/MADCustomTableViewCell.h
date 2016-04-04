//
//  MADCustomTableViewCell.h
//  News
//
//  Created by Mariia Cherniuk on 04.04.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADCustomTableViewCell : UITableViewCell

@property (strong, nonatomic, readwrite) UILabel *headline;
@property (strong, nonatomic, readwrite) UIImageView *image;
@property (strong, nonatomic, readwrite) UILabel *author;

@end
