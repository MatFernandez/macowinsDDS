class Sucursal {

	const property historialVentas = []

	method recaudacionDeUnDia(fechaParticular) = self.ventasDeUnDiaParticular(fechaParticular).sum({ venta => venta.precioFinalDeVenta() })

	method ventasDeUnDiaParticular(fechaParticular) = historialVentas.filter({ venta => venta.fechaDeVenta() == fechaParticular })

}

class Venta {

	const property prendasVendidas = []
	var property fechaDeVenta = new Date()
	var property pagaEnEfectivo = true // Aca habia pensado en la alternativa de una clase metodoDePago y mover toda la responsabilidad para que no este todo en 
	var property cantidadDeCuotas      // la venta, usando herencia para efectivo o pago con tarjeta
	var property recargoPorCuotas

	method precioFinalDeVenta() = if (pagaEnEfectivo) self.preciosDeLasVentasBase() else self.precioFinalDeVentasEnCuotas()

	method preciosDeLasVentasBase() = prendasVendidas.sum({ prenda => prenda.precioDeVenta() })

	method precioFinalDeVentasEnCuotas() = self.preciosDeLasVentasBase() + (cantidadDeCuotas * recargoPorCuotas + self.recargoFijoPorPrenda() )

	method recargoFijoPorPrenda() = prendasVendidas.sum({ prenda => prenda.precioDeVenta() * 0.01 })

}

class Prenda {

	var property precioBase
	var property estadoDePrenda

	method precioDeVenta() = estadoDePrenda.modificadorDePrecio(self)

}

class Nueva { //En wollok en realidad deberia ser un object, pero para hacerlo "lo mas parecido" a java posible

	method modificadorDePrecio(prenda) = prenda.precioBase()

}

class Promocion {

	var property valorFijo

	method modificadorDePrecio(prenda) = prenda.precioBase() - valorFijo

}

class Liquidacion { //Tambien deberia ser un object en wollok

	method modificadorDePrecio(prenda) = prenda.precioBase() * 0.5

}

/* ---SOBRE EL CODIGO---

-General:
-Lo resolvi en wollok porque la verdad no me sentia seguro haciendolo en java. Deje los objects como clases para medianamente ir acostumbrandome (por eso la aclaracion en algunas clases).

-Sobre la solucion:
*Me hizo bastante ruido los tipos de prendas (en este caso en wollok) por eso no hay nada de ellas. Lei que en java podian incluirse como Enum, me surgio la duda si en el diagrama de clases estas debian incluirse?
*Sobre la clase venta, a lo mejor era conveniente tambien crear una clase medioDePago donde se haga toda la logica del costo de la venta con cuotas, recargos etc etc usando herencia para efectivo y pago con tarjeta y no meter todo eso ahi adentro.

-Y supongo que eso es todo 
*/

