(function(){

  // THESE VARIABLES YOU MUST SET AS YOU LIKE
  var toleranceToDark = 0;
  var lightColor = "#dddddd";
  var darkColor = "#222222";
  var className = "dark-or-light-bg";
  var hoverClassName = "dark-or-light-hover";

  // OK, NOW IS THE CODE
  var darkOrLight = function(){

    var darkOrLightElements = document.getElementsByClassName(className);
    var hoverElements = document.getElementsByClassName(hoverClassName);

    var switchColor = function(){

      var red;
      var green;
      var blue;
      var lightness;
      var bg;
      var mediumValue = 127; // 255/2

      for (i = 0; i < darkOrLightElements.length; i++) {

        bg = window.getComputedStyle(darkOrLightElements[i]).getPropertyValue('background-color');
        // bg = darkOrLightElements[i].style.backgroundColor;

        // console.log(darkOrLightElements[i].tagName + " - " + bg);
        if (bg == "transparent") {
          var ancestor = darkOrLightElements[i].parentNode;
          for(;;){

            bg = window.getComputedStyle(ancestor).getPropertyValue('background-color');
            // bg = darkOrLightElements[i].style.backgroundColor;
            // console.log(ancestor.tagName + " - " + bg);

            if (bg != "transparent") break;
            ancestor = ancestor.parentNode;
          }
        }
        console.log(darkOrLightElements[i].tagName + " - " + bg);

        red = bg.split("(")[1].split(", ")[0];
        green = bg.split("(")[1].split(", ")[1];
        blue = bg.split("(")[1].split(", ")[2].split(")")[0];
        lightness = (parseInt(red, 10) + parseInt(green, 10) + parseInt(blue, 10)) / 3;

        if (lightness < (mediumValue + toleranceToDark)){
          darkOrLightElements[i].style.color = lightColor;
        } else {
          darkOrLightElements[i].style.color = darkColor;
        }
      }

    }

    if (darkOrLightElements.length > 0) {
      switchColor();
      if (hoverElements.length > 0) {
        for (i = 0; i < hoverElements.length; i++) {
          hoverElements[i].addEventListener('mouseenter', switchColor);
          hoverElements[i].addEventListener('mouseleave', switchColor);
          // window.addEventListener('mousemove', switchColor);
        }
      }
    }

  }

  window.addEventListener('load', darkOrLight);

})();
