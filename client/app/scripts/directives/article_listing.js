angular.module('shareupApp')
.directive('articleListing', function() {
  return {
    restrict: 'EA',
    require: 'ngModel',
    scope: {
      ngModel: '=',
      onShare: '&'
    },
    templateUrl: 'views/article_listing.html',
    link: function(scope, ele, attrs, ctrl) {}
  }
})