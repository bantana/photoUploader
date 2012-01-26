
#import <UIKit/UIKit.h>


@interface MyViewController : UIViewController
{
    UILabel *pageNumberLabel;
    int pageNumber;
    
    UILabel *numberTitle;
    UIImageView *numberImage;
}

@property (nonatomic, retain) IBOutlet UILabel *pageNumberLabel;

@property (nonatomic, retain) IBOutlet UILabel *numberTitle;
@property (nonatomic, retain) IBOutlet UIImageView *numberImage;

- (id)initWithPageNumber:(int)page;

@end
