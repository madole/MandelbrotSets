Mandelbrot = require './Mandelbrot'
$button = $('#submit')

$button.click ->
	iterations = $('#iterations').val()
	Mandelbrot.calculateMandlebrot 900, 600, -2, 1, -1, 1, iterations