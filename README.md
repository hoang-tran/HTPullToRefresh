## This is a fork from the famous [SVPullToRefresh](https://github.com/samvermette/SVPullToRefresh) pod with 2 additional functionalities:
- [x] Can add multiple pull-to-refresh views into one single UIScrollView
- [x] Support pull Left/Right to refresh

![Vertical](https://media.giphy.com/media/l46CbE0xUpHQXdx1S/giphy.gif)        ![Horizontal](https://media.giphy.com/media/26BRx2KZGqMoYHYM8/giphy.gif)

## Installation

Add `pod 'HTPullToRefresh'` to your Podfile (remove the `SVPullToRefresh` pod if you had added it before)

## Usage

(see sample Xcode project in `/Demo`)

### Adding Pull to Refresh

If you don't specify the position, it will add to top by default 

```objective-c

[tableView addPullToRefreshWithActionHandler:^{
  //do stuff
}];
```
or if you want it from the bottom

```objective-c
[tableView addPullToRefreshWithActionHandler:^{
  //do stuff
} position:SVPullToRefreshPositionBottom];
```

or from the left

```objective-c
[tableView addPullToRefreshWithActionHandler:^{
  //do stuff
} position:SVPullToRefreshPositionLeft];
```

or right?

```objective-c
[tableView addPullToRefreshWithActionHandler:^{
  //do stuff
} position:SVPullToRefreshPositionRight];
```

or add multiple pull-to-refresh views all at once

```objective-c
// add top
[tableView addPullToRefreshWithActionHandler:^{
  //do stuff
} position:SVPullToRefreshPositionBottom];

// then add bottom
[tableView addPullToRefreshWithActionHandler:^{
  //do stuff
} position:SVPullToRefreshPositionLeft];
```

### Retrieve Pull to Refresh View

Retrieve first pull-to-refresh view:

```objective-c
tableView.pullToRefreshView
```

Retrieve pull-torefresh view at a specific position:

```objective-c
[tableView pullToRefreshViewAtPosition:SVPullToRefreshPositionBottom];
```

Since we have multiple pull-to-refresh views inside a UIScrollView, we can retrieve all of them by:

```objective-c
tableView.pullToRefreshViews
```

#### Customization

The pull to refresh view can be customized using the following properties/methods:

```objective-c
@property (nonatomic, strong) UIColor *arrowColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, readwrite) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

- (void)setTitle:(NSString *)title forState:(SVPullToRefreshState)state;
- (void)setSubtitle:(NSString *)subtitle forState:(SVPullToRefreshState)state;
- (void)setCustomView:(UIView *)view forState:(SVPullToRefreshState)state;
```

For instance, you would set the `arrowColor` property using:

```objective-c
tableView.pullToRefreshView.arrowColor = [UIColor whiteColor];
```

### Adding Infinite Scrolling

```objective-c
[tableView addInfiniteScrollingWithActionHandler:^{
    // append data to data source, insert new cells at the end of table view
    // call [tableView.infiniteScrollingView stopAnimating] when done
}];
```

If you’d like to programmatically trigger the loading (for instance in `viewDidAppear:`), you can do so with:

```objective-c
[tableView triggerInfiniteScrolling];
```

You can temporarily hide the infinite scrolling view by setting the `showsInfiniteScrolling` property:

```objective-c
tableView.showsInfiniteScrolling = NO;
```

#### Customization

The infinite scrolling view can be customized using the following methods:

```objective-c
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle;
- (void)setCustomView:(UIView *)view forState:(SVInfiniteScrollingState)state;
```

You can access these properties through your scroll view's `infiniteScrollingView` property.

## Under the hood

SVPullToRefresh extends `UIScrollView` by adding new public methods as well as a dynamic properties. 

It uses key-value observing to track the scrollView's `contentOffset`.

## Credits

SVPullToRefresh is brought to you by [Sam Vermette](http://samvermette.com) and [contributors to the project](https://github.com/samvermette/SVPullToRefresh/contributors). If you have feature suggestions or bug reports, feel free to help out by sending pull requests or by [creating new issues](https://github.com/samvermette/SVPullToRefresh/issues/new). If you're using SVPullToRefresh in your project, attribution would be nice. 

Big thanks to [@seb_morel](http://twitter.com/seb_morel) for his [Demistifying the Objective-C runtime](http://cocoaheadsmtl.s3.amazonaws.com/demistifying-runtime.pdf) talk which really helped for this project. 

Hat tip to [Loren Brichter](http://twitter.com/lorenb) for inventing pull-to-refresh.
