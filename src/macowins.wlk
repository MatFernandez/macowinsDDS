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

