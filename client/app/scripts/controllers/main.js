'use strict';

angular.module('shareupApp')
  // Main controller with the latest articles
  // This will never be routed to unless we have an authenticated user
  .controller('MainCtrl', function ($scope, $http, ArticleService) {
    $scope.currentUser = {};
    ArticleService.getLatestFeed()
    .then(function(data) {
      $scope.articles = data;
    });
  });
