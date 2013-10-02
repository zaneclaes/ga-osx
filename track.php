<!DOCTYPE html>
<html>
<body>
<script>  
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'YOUR_ANALYTICS_PROFILE_ID']);
  _gaq.push(['_setDomainName', 'YOUR_DOMAIN_NAME']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
  
  function trackView(screen) {
      _gaq.push(['_trackPageview',screen]);
      return true;
  }

  function trackTiming(category, time, name, label) {
      _gaq.push(['_trackTiming', category, name, time, label]);
      return true;
  }
  
  function trackEvent(category, action, label, value) {
      _gaq.push(['_trackEvent', category, action, label, value]);
      return true;
  }
</script>
</body>
</html>