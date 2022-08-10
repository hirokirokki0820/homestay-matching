// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import jquery from "jquery"
window.$ = window.jQuery = jquery
window.bootstrap = require("bootstrap")


// $(document).on('turbo:load', function() {
//   $('#images_upload').on('change',function(e){
//     var files = e.target.files;
//     var d = (new $.Deferred()).resolve();
//     $.each(files,function(file){
//       d = d.then(function(){return previewImage(file)});
//     });
//   })

//   var previewImage = function(imageFile){
//     var reader = new FileReader();
//     var img = new Image();
//     var def =$.Deferred();
//     reader.onload = function(e){
//       $('#preview').append(img);
//       img.src = e.target.result;
//       img.id = "preview_image";
//       img.width = 100;
//       def.resolve(img);
//     };
//     reader.readAsDataURL(imageFile);
//     return def.promise();
//   }

// })
