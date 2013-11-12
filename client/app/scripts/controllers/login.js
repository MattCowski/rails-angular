'use strict';

angular.module('shareupApp')
  // Our login controller that will handle 
  .controller('LoginCtrl', function ($location, $scope, $http, tokenHandler) {
    // Signup action
    $scope.signup = function() {
      $http({
        url: '/api/users',
        method: 'POST',
        data: { user: $scope.user }
      }).success(function(data) {
        // If the request is successful, and the user
        // has been created: store the auth_token,
        // broadcast the 'authenticated' event across
        // our app, and redirect to '/'
        tokenHandler.set( data.auth_token );
        $scope.$broadcast('event:authenticated');
        $location.path('/');
      }).error(function(reason) {
        // Store the errors to format on screen
        $scope.user.errors = reason;
      });
    };
    // login action
    $scope.login = function() {
      // Post to our api sign_in route
      $http({
        url: '/api/users/sign_in',
        method: 'POST',
        data: { user: $scope.user }
      }).success(function(data) {
        if (data.success) {
          // If we get back an authenticated user (indicated by
          // the success in the response, not if the response 
          // returns 401 - so we can capture the user errors
          $scope.ngModel = data.data.data;
          tokenHandler.set(data.data.auth_token);
          $location.path('/');
        } else {
          $scope.ngModel = data;
          $scope.user.errors = data.info;
        }
      });
    };
  });
