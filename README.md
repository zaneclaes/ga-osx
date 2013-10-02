ga-osx
======

Google Analytics for OSX Apps
Setup: 

1) Open track.php and replace `YOUR_ANALYTICS_PROFILE_ID` with your GAN profile ID (eg, `UA-XXXXXX`) and `YOUR_DOMAIN_NAME` with the domain name of your profile.
2) Upload track.php to your web server
3) Copy the GoogleAnalyticsReporting class into your project, and make sure that you've linked the `WebKit.framework`
4) Use the URL to the track.php file to initialize an instance of the class: `GoogleAnalyticsReporting *analytics = [[GoogleAnalyticsReporting alloc] initWithURL:@"your_url" inWindow:yourWindow];`
5) Track any events, pageviews, etc. you want. The syntax should conform to Google's mobile SDK... for example: `[analytics sendView:@"myViewName"];`
