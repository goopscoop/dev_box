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
  .factory('devValidate', function(){

    var isValidated = function( testEl, errMessage, optionalTestEl, optionalTestEl2 ){
      if( testEl || optionalTestEl || optionalTestEl2 ) {
        return true;
      } else {
        Materialize.toast( errMessage, 4000)
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
  })