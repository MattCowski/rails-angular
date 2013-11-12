angular.module('shareupApp')
.filter('toDate', function() {
  return function(input) {
    return new Date(input);
  }
});