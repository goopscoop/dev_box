DevBox.factory('buildUrl', function(){
     // builds url. API is required (true if api call, false if local url)
    // all other paramaters are optional.
  return {
    build: function( api, query, cats, tags ){
      if ( api ) {
        var url =  '/api/tools?'
      } else {
        url = ''
      }
      if ( query ) url += 'q=' + query;
      if ( (query && cats) || (query && tags) ) url += '&';
      if ( cats ) url += 'c=' + cats;
      if ( cats && tags ) url += '&';
      if ( tags ) url += 't=' + tags;
      return url
    }
  }
})
  .factory('devValidate',[ 'devAlert', function( devAlert ){

    var isValidated = function( testEl, errMessage, optionalTestEl, optionalTestEl2 ){
      if( testEl || optionalTestEl || optionalTestEl2 ) {
        return true;
      } else {
        devAlert.alert( errMessage);
        return false;
      }
    }

    return {
      title: function( toolTitle ){
        return isValidated( toolTitle, 'a title is required' );
      },
      category: function( toolCategory ){
        return isValidated( toolCategory, 'a category is required' );
      },
      description: function( toolDescription ){
        return isValidated( toolDescription, 'a description is required' );
      },
      urls: function( webUrl, repoUrl, docsUrl ){
        return isValidated( webUrl, 'at least one link is required', repoUrl, docsUrl );
      },
      tags: function( toolTags ){
        return isValidated( toolTags, 'at least one tag is required' )
      },
      custom: function( customEl, message, optionalEl, optionalEl2 ){
        return isValidated( customEl, message, optionalEl, optionalEl2 )
      }
    }
  }])

  .factory('devAlert',  function(){
    return {
      alert: function( message, optionalDuration ){
        Materialize.toast( message, optionalDuration || 4000)
      }
    }
  })

  .factory('devSearchFn', [ '$http', function( $http ){

    return {
      focus: function( selectedTool ){
        if ( selectedTool ) {
          searchTools = [];
          searchTools.push(selectedTool);
          return searchTools;
        }
      },
      check: function( toolSearchText){
        if( toolSearchText ){
          return true
        } else {
          return false
        }
      }
    }
  }])

  .factory('devInit', [ '$http', '$q', function( $http, $q ){
    return {
      categories: [],
      tags: [],
      errorMsg: "Something went wrong with the devInit loading service",
      loadCatsAndTags: function(){
        var that = this;
        if( this.categories == false || this.tags == false ){
          return $http.get( '/api/tags-and-cats/' )
          .then( function( data ){
            that.categories = data.data.categories;
            that.tags = data.data.tags;
            return {
              categories: data.data.categories,
              tags: data.data.tags }
            }
          )
        } else {
          var deferred = $q.defer()
          deferred.resolve({
            categories: this.categories,
            tags: this.tags
          });
          deferred.reject( that.errorMsg )
          return deferred.promise;
        }
      },
      notLoaded: function(categories, tags){
        return !categories || !tags ? true : false;
      },
      apiGet: function( url ){
        return $http.get( url )
        .then( function( data ){
          return data.data;
        } )
      }
    }
  }])


