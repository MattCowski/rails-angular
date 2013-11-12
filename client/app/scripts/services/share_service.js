angular.module('shareupApp')
.factory('ShareService', function($resource, $q, tokenHandler) {
  var Share = $resource('/api/shares/:id',
    {id: '@id'},
    {}
    );

  tokenHandler.wrapActions(Share, ["save"]);

  return Share;
});