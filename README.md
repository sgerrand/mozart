# Mozart - A Clientside MVC Framework in CoffeeScript

*Version 0.1.7, 1 June 2013*

Please see http://mozart.io for documentation, examples etc.

# Changelog

## 0.1.7

* Introduced transferrable bindings to correct problems with new binding implementation
* Extra specs and tests for greater code coverage

## 0.1.6

* HTTP Abstraction Layer
* i18n Bugfixes, Lookup properties allowed
* Firefox popstate fixes
* Fixed Double-route bug when using Browser History routing
* Plugin Framework

## 0.1.5

* Rewrote MztObject binding
* Refactored for node 0.10.0 support

## 0.1.4

* Updated Mozart Build Chain to use Grunt v0.4.0

## 0.1.3

* Moved to Browser History based routing, Hash routing is an optional mode

## 0.1.2

* i18n now conforms to RFC4646
* DOM Manager reworked to support more events
* More descriptive exceptions and warnings
* Minor bug fixes

## 0.1.1

* Added *Lookup properties to MztObject, action helper
* View handlebars helper can now take a property as the viewclass (partials)
* Added CoDo Document Generation

## 0.1.0

* Added localStorage support

## 0.0.9

* Renamed to Mozart

## 0.0.8

* Major fixes to IE compatibility. Now works in IE8+.

## 0.0.7

* Switched to Grunt from Brunch
* Views are now deferred for release, and released off-DOM
* Mozart Framework now uses CommonJS
* Global Keybindings in DOMManager

## 0.0.6

* Added messageFormat Internationalization support

## 0.0.5

* Added basic AJAX layer

## 0.0.4

* Added mobile ToDo App demo, added mobile generators, fixed IE incompatibiliy bug

## 0.0.3

* Renamed from RazorMVC, including all namespaces

## 0.0.2

* New, faster off-DOM render engine