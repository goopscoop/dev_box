// Angular-EpicEditor slighly modified from https://github.com/e154/angular-epiceditor

(function(){
  'use strict';

  angular
    .module('ui.epiceditor', [])
    .directive('uiEpicEditor', function(){
      return {
        replace: true,
        scope: {
          'ngModel': "="
        },
        template:'<div class="epic-editor"></div>',
        link: function(scope, element, attrs, ngModel) {

          var opts = {
              container: element.get(0),
              textarea: null,
              basePath: '/admin/static/private/bower_components/EpicEditor/epiceditor',
              clientSideStorage: false,
              localStorageName: 'epiceditor',
              useNativeFullscreen: true,
              parser: marked,
              file: {
                  name: 'epiceditor',
                  defaultContent: '',
                  autoSave: 100
              },
              theme: {
                base: 'https://rawgit.com/ncronquist/4c9211a66a627286f6c8/raw/562c29dfc024c2cdf21786eeceda55403599bd37/epiceditor.css',
                preview: 'https://rawgit.com/ncronquist/82821f114e29876a7a7c/raw/fffc2a8b6fbcfa0abdef124c784ef1befe1efaba/epic-dark.css',
                editor: 'https://rawgit.com/ncronquist/82821f114e29876a7a7c/raw/fffc2a8b6fbcfa0abdef124c784ef1befe1efaba/epic-dark.css'
              },
              button: {
                  preview: true,
                  fullscreen: true,
                  bar: "auto"
              },
              focusOnLoad: false,
              shortcut: {
                  modifier: 18,
                  fullscreen: 70,
                  preview: 80
              },
              string: {
                  togglePreview: 'Toggle Preview Mode',
                  toggleEdit: 'Toggle Edit Mode',
                  toggleFullscreen: 'Enter Fullscreen'
              },
              autogrow: {
                  minHeight: 250,
                  maxHeight: false,
                  scroll: true
              }
          };

          var editor = new EpicEditor(opts);

          editor.load(function () {

            var iFrameEditor = editor.getElement('editor');

            // we get body dom element, because this is contenteditable=true
            // http://stackoverflow.com/questions/6256342/trigger-an-event-when-contenteditable-is-changed
            var contents = $('body',iFrameEditor).html();
            $('body',iFrameEditor).blur(function() {
              if (contents!=$(this).html()){
                  contents = $(this).html(); // set to new content
                  editor.save(); // important!
                  scope.ngModel = editor.exportFile();
                  scope.$apply();
              }
            });
          });

          // Editor unloaded
          scope.$on('$destroy', function (event, next, current) {
            editor.unload(function () {
                //...
            });
          });

          scope.$watch('ngModel', function (newValue, oldValue) {
            editor.importFile('content', newValue);
          });
        }
      }
    });
}());