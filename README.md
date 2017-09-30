
my\_jspp
========

My personal tool to manage [Javascript++](https://www.onux.com/jspp/)
projects.

Notes:
======

  the runtime "TypeError" object is only available from JavaScript. (JS++ catches all type errors for non-external types at compile time.) The trick was to add this line at the top instead of removing your code:

  external TypeError, RangeError;

  Convenience modules that import all JavaScript/DOM symbols as "external" are also available so you don't have to manually mark JavaScript objects as 'external':

  import Externals.JS;
import Externals.DOM;
