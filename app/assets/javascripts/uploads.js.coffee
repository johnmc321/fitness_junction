# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  Morris.Line
  element: 'graph'
  data: [
    {y: '2012', a: 5}
    {y: '2011', a: 1}
    {y: '2010', a: 2}
    {y: '2009', a: 7}
    {y: '2008', a: 4}
    {y: '2007', a: 5}
    {y: '2006', a: 2}
    {y: '2005', a: 7}
    {y: '2004', a: 8}
  ]
  xkey: 'y'
  ykeys: ['a']
  labels: ['Series A']
