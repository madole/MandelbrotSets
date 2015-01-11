Mandeliter = (cx, cy, maxiter) ->
	x = 0.0
	y = 0.0
	xx = 0
	yy = 0
	xy = 0

	i = maxiter

	while i-- && xx + yy <= 4
		xy = x * y
		xx = x * x
		yy = y * y
		x = xx - yy + cx
		y = xy + xy + cy
	maxiter - i


Mandelbrot = (width, height, xmin, xmax, ymin, ymax, iterations) ->
	canvas = document.getElementById 'fractalCanvas'
	if not canvas
		canvas = document.createElement 'canvas'
		canvas.id = 'fractalCanvas'
		canvas.width = width
		canvas.height = height
		
	ctx = canvas.getContext '2d'
	img = ctx.getImageData 0, 0, width, height
	pix = img.data

	for ix in [0..width]
		for iy in [0..height]
			x = xmin + (xmax - xmin) * ix / (width - 1)
			y = ymin + (ymax - ymin) * iy / (height - 1)
			i = Mandeliter x, y, iterations
			ppos = 4 * (width * iy + ix)

			if i is iterations
				pix[ppos] = 0
				pix[ppos + 1] = 0
				pix[ppos + 2] = 0
			else
				c = 3 * Math.log(i)/Math.log(iterations - 1.0)
				if c < 1
					pix[ppos] = 225 * c
					pix[ppos + 1] = 0					
					pix[ppos + 2] = 0
				else if c < 2
					pix[ppos] = 255
					pix[ppos + 1] = 255 * (c - 1)
					pix[ppos + 2] = 0
				else
					pix[ppos] = 255
					pix[ppos + 1] = 255
					pix[ppos + 2] = 255 * (c - 2)

			pix[ppos + 3] = 255
	ctx.putImageData img, 0 ,0
	document.body.insertBefore canvas, document.body.childNodes[0]

Mandelbrot 900, 600, -2, 1, -1, 1, 1000

exports.calculateMandlebrot = Mandelbrot